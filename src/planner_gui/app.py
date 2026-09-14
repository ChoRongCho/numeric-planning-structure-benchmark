"""Tk GUI for running and inspecting one PDDL planning case."""

from __future__ import annotations

import json
import os
import queue
import shlex
import shutil
import signal
import subprocess
import sys
import threading
import time
from datetime import datetime
from pathlib import Path
import tkinter as tk
from tkinter import filedialog, messagebox, ttk
from tkinter.scrolledtext import ScrolledText

ROOT = Path(__file__).resolve().parents[2]
RUNNER_DIR = ROOT / "scripts" / "run"
if str(RUNNER_DIR) not in sys.path:
    sys.path.insert(0, str(RUNNER_DIR))

from benchmark_core import validate_plan  # noqa: E402
from planner_adapters import classify, extract_plan, render_plan  # noqa: E402

try:  # Package import for tests/tools; direct import for ./run_gui.py.
    from .profiles import (GUI_ID_BY_NAME, GUI_PLANNER_NAMES, PROFILE_BY_ID,
                           PROFILES, build_command)  # type: ignore
    from .catalog import DomainEntry, discover_catalog, problems_for  # type: ignore
except ImportError:
    from profiles import (GUI_ID_BY_NAME, GUI_PLANNER_NAMES, PROFILE_BY_ID,
                          PROFILES, build_command)  # type: ignore  # noqa: E402
    from catalog import DomainEntry, discover_catalog, problems_for  # type: ignore  # noqa: E402


def read_saved_actions(work: Path, planner_id: str) -> list[str]:
    """Read planners that emit their plan to a file instead of stdout."""
    candidates: list[Path] = []
    if planner_id == "pattint-bitwuzla":
        candidates = [work / "pattint.plan"]
    elif planner_id.startswith("tamerlite-ipc2026-"):
        candidates = [work / "tamerlite.plan"]
    elif planner_id == "numeric-fast-downward-local" or planner_id.startswith("count-downward-"):
        candidates = sorted(work.glob("sas_plan*"), key=lambda path: path.stat().st_mtime_ns, reverse=True)
    for candidate in candidates:
        if candidate.is_file():
            actions = [
                line.strip() for line in candidate.read_text(errors="replace").splitlines()
                if line.strip().startswith("(") and line.strip().endswith(")")
            ]
            if actions:
                return actions
    return []


class PlannerGUI(tk.Tk):
    POLL_MS = 100

    def __init__(self) -> None:
        super().__init__()
        self.title("Numeric Planning — Single Case")
        self.geometry("1280x760")
        self.minsize(1000, 650)
        self.protocol("WM_DELETE_WINDOW", self._close)

        self.events: queue.Queue[tuple[str, object]] = queue.Queue()
        self.process: subprocess.Popen[str] | None = None
        self.worker: threading.Thread | None = None
        self.last_plan: Path | None = None
        self.option_vars: dict[str, tk.StringVar] = {}
        self.domain_entries: dict[str, DomainEntry] = {}
        self.problem_entries: dict[str, Path] = {}

        self.domain_var = tk.StringVar()
        self.problem_var = tk.StringVar()
        self.planner_var = tk.StringVar(value="enhsp")
        self.heuristic_var = tk.StringVar()
        self.search_var = tk.StringVar()
        self.timeout_var = tk.StringVar(value="60")
        self.cores_var = tk.StringVar(value="2")
        self.extra_var = tk.StringVar()
        self.validate_var = tk.BooleanVar(value=True)
        self.status_var = tk.StringVar(value="준비")
        self.profile_help_var = tk.StringVar()
        self.command_var = tk.StringVar()

        self._configure_style()
        self._build_ui()
        self._set_profile()
        self._load_catalog()
        for variable in (self.problem_var, self.heuristic_var, self.search_var, self.extra_var):
            variable.trace_add("write", lambda *_: self._refresh_command_preview())
        self.after(self.POLL_MS, self._poll_events)

    def _configure_style(self) -> None:
        style = ttk.Style(self)
        if "clam" in style.theme_names():
            style.theme_use("clam")
        style.configure("Title.TLabel", font=("TkDefaultFont", 16, "bold"))
        style.configure("Status.TLabel", padding=(8, 5))

    def _build_ui(self) -> None:
        outer = ttk.Frame(self, padding=14)
        outer.pack(fill="both", expand=True)
        ttk.Label(outer, text="단일 PDDL Planner 실행", style="Title.TLabel").pack(anchor="w")
        ttk.Label(outer, text="Domain과 problem을 고르고 한 configuration을 실행합니다.").pack(anchor="w", pady=(2, 12))

        panes = ttk.Panedwindow(outer, orient="horizontal")
        panes.pack(fill="both", expand=True)
        left = ttk.Frame(panes, padding=(0, 0, 7, 0))
        right = ttk.Frame(panes, padding=(7, 0, 0, 0))
        panes.add(left, weight=1)
        panes.add(right, weight=1)

        form = ttk.LabelFrame(left, text="입력 및 planner 설정", padding=10)
        form.pack(fill="both", expand=True)
        form.columnconfigure(1, weight=1)
        ttk.Label(form, text="Domain").grid(row=0, column=0, sticky="w", padx=(0, 8), pady=4)
        self.domain_combo = ttk.Combobox(form, textvariable=self.domain_var, state="readonly")
        self.domain_combo.grid(row=0, column=1, sticky="ew", pady=4)
        self.domain_combo.bind("<<ComboboxSelected>>", lambda _event: self._set_domain())
        ttk.Button(form, text="직접 선택…", command=self._browse_domain).grid(row=0, column=2, padx=(8, 0), pady=4)

        ttk.Label(form, text="Problem").grid(row=1, column=0, sticky="w", padx=(0, 8), pady=4)
        self.problem_combo = ttk.Combobox(form, textvariable=self.problem_var, state="readonly")
        self.problem_combo.grid(row=1, column=1, sticky="ew", pady=4)
        ttk.Button(form, text="직접 선택…", command=self._browse_problem).grid(row=1, column=2, padx=(8, 0), pady=4)

        ttk.Label(form, text="Planner").grid(row=2, column=0, sticky="w", padx=(0, 8), pady=4)
        self.planner_combo = ttk.Combobox(form, textvariable=self.planner_var, state="readonly",
                                          values=GUI_PLANNER_NAMES)
        self.planner_combo.grid(row=2, column=1, columnspan=2, sticky="ew", pady=4)
        self.planner_combo.bind("<<ComboboxSelected>>", lambda _event: self._set_profile())

        ttk.Label(form, text="Heuristic").grid(row=3, column=0, sticky="w", padx=(0, 8), pady=4)
        self.heuristic_combo = ttk.Combobox(form, textvariable=self.heuristic_var, state="readonly")
        self.heuristic_combo.grid(row=3, column=1, columnspan=2, sticky="ew", pady=4)

        ttk.Label(form, text="Search").grid(row=4, column=0, sticky="w", padx=(0, 8), pady=4)
        self.search_combo = ttk.Combobox(form, textvariable=self.search_var, state="readonly")
        self.search_combo.grid(row=4, column=1, columnspan=2, sticky="ew", pady=4)

        self.dynamic = ttk.Frame(form)
        self.dynamic.grid(row=5, column=0, columnspan=3, sticky="ew", pady=(2, 0))
        self.dynamic.columnconfigure(1, weight=1)

        controls = ttk.Frame(form)
        controls.grid(row=6, column=0, columnspan=3, sticky="ew", pady=(8, 0))
        ttk.Label(controls, text="Timeout (초)").pack(side="left")
        ttk.Spinbox(controls, from_=1, to=86400, width=8, textvariable=self.timeout_var).pack(side="left", padx=(6, 16))
        ttk.Label(controls, text="CPU cores").pack(side="left")
        ttk.Spinbox(controls, from_=1, to=max(1, os.cpu_count() or 1), width=5, textvariable=self.cores_var).pack(side="left", padx=(6, 16))
        ttk.Checkbutton(controls, text="VAL로 plan 검증", variable=self.validate_var).pack(side="left")

        ttk.Label(form, text="추가 인자").grid(row=7, column=0, sticky="w", padx=(0, 8), pady=4)
        ttk.Entry(form, textvariable=self.extra_var).grid(row=7, column=1, columnspan=2, sticky="ew", pady=4)
        ttk.Label(form, textvariable=self.profile_help_var, foreground="#345").grid(
            row=8, column=0, columnspan=3, sticky="w", pady=(6, 0)
        )

        actionbar = ttk.Frame(left)
        actionbar.pack(fill="x", pady=(10, 0))
        self.plan_button = ttk.Button(actionbar, text="Plan", command=self._start)
        self.plan_button.pack(side="left")
        self.cancel_button = ttk.Button(actionbar, text="중지", command=self._cancel, state="disabled")
        self.cancel_button.pack(side="left", padx=8)
        self.save_button = ttk.Button(actionbar, text="Plan 다른 이름으로 저장", command=self._save_plan, state="disabled")
        self.save_button.pack(side="left")
        ttk.Label(left, textvariable=self.status_var, style="Status.TLabel").pack(fill="x", pady=(4, 0))

        command_frame = ttk.LabelFrame(right, text="실행 명령", padding=7)
        command_frame.pack(fill="x", pady=(0, 10))
        ttk.Label(command_frame, textvariable=self.command_var, wraplength=560).pack(anchor="w")

        notebook = ttk.Notebook(right)
        notebook.pack(fill="both", expand=True)
        plan_tab = ttk.Frame(notebook, padding=6)
        log_tab = ttk.Frame(notebook, padding=6)
        notebook.add(plan_tab, text="Plan")
        notebook.add(log_tab, text="실행 로그")
        self.plan_text = ScrolledText(plan_tab, wrap="none", font=("TkFixedFont", 10))
        self.plan_text.pack(fill="both", expand=True)
        self.log_text = ScrolledText(log_tab, wrap="none", font=("TkFixedFont", 9))
        self.log_text.pack(fill="both", expand=True)
        self.notebook = notebook

    def _load_catalog(self) -> None:
        entries = discover_catalog(ROOT)
        self.domain_entries = {entry.label: entry for entry in entries}
        self.domain_combo.configure(values=list(self.domain_entries))
        if entries:
            self.domain_var.set(entries[0].label)
            self._set_domain()

    def _set_domain(self) -> None:
        entry = self.domain_entries.get(self.domain_var.get())
        self.problem_entries = {}
        if entry:
            self.problem_entries = {problem.name: problem for problem in entry.problems}
        labels = list(self.problem_entries)
        self.problem_combo.configure(values=labels, state="readonly" if labels else "disabled")
        self.problem_var.set(labels[0] if labels else "instance 없음")
        self._refresh_command_preview()

    def _browse_domain(self) -> None:
        value = filedialog.askopenfilename(title="PDDL domain 선택", initialdir=ROOT / "benchmarks",
                                           filetypes=[("PDDL", "*.pddl"), ("모든 파일", "*")])
        if value:
            domain = Path(value).resolve()
            problems = problems_for(domain)
            label = f"[직접] {domain.parent.name} — {len(problems)} instance(s)"
            # Include the path if a catalog domain with the same directory name exists.
            if label in self.domain_entries and self.domain_entries[label].domain != domain:
                label = f"[직접] {domain} — {len(problems)} instance(s)"
            self.domain_entries[label] = DomainEntry(label, domain, problems, "직접")
            self.domain_combo.configure(values=list(self.domain_entries))
            self.domain_var.set(label)
            self._set_domain()

    def _browse_problem(self) -> None:
        domain = self._domain_path()
        initial = domain.parent / "instances" if domain else ROOT / "benchmarks"
        value = filedialog.askopenfilename(title="PDDL problem 선택", initialdir=initial,
                                           filetypes=[("PDDL", "*.pddl"), ("모든 파일", "*")])
        if value:
            problem = Path(value).resolve()
            label = f"[직접] {problem.name}"
            self.problem_entries[label] = problem
            self.problem_combo.configure(values=list(self.problem_entries), state="readonly")
            self.problem_var.set(label)

    def _domain_path(self) -> Path | None:
        entry = self.domain_entries.get(self.domain_var.get())
        return entry.domain if entry else None

    def _problem_path(self) -> Path | None:
        return self.problem_entries.get(self.problem_var.get())

    @staticmethod
    def _labels(items) -> list[str]:
        return [item.label for item in items]

    @staticmethod
    def _value(items, label: str) -> str:
        return next((item.value for item in items if item.label == label), "")

    def _set_profile(self) -> None:
        profile = PROFILE_BY_ID[GUI_ID_BY_NAME[self.planner_var.get()]]
        self.heuristic_combo.configure(values=self._labels(profile.heuristics),
                                       state="readonly" if len(profile.heuristics) > 1 else "disabled")
        self.search_combo.configure(values=self._labels(profile.searches),
                                    state="readonly" if len(profile.searches) > 1 else "disabled")
        self.heuristic_var.set(profile.heuristics[0].label)
        self.search_var.set(profile.searches[0].label)
        self.profile_help_var.set(f"{profile.family} · {profile.description}")
        for child in self.dynamic.winfo_children():
            child.destroy()
        self.option_vars.clear()
        for row, spec in enumerate(profile.options):
            variable = tk.StringVar(value=spec.choices[0].label)
            variable.trace_add("write", lambda *_: self._refresh_command_preview())
            self.option_vars[spec.key] = variable
            ttk.Label(self.dynamic, text=spec.label).grid(row=row, column=0, sticky="w", padx=(0, 8), pady=3)
            ttk.Combobox(self.dynamic, textvariable=variable, state="readonly",
                         values=self._labels(spec.choices)).grid(row=row, column=1, sticky="ew", pady=3)
        self._refresh_command_preview()

    def _selection(self) -> tuple[str, str, str, dict[str, str]]:
        profile = PROFILE_BY_ID[GUI_ID_BY_NAME[self.planner_var.get()]]
        heuristic = self._value(profile.heuristics, self.heuristic_var.get())
        search = self._value(profile.searches, self.search_var.get())
        options = {
            spec.key: self._value(spec.choices, self.option_vars[spec.key].get())
            for spec in profile.options
        }
        return profile.planner_id, heuristic, search, options

    def _command(self, domain: Path, problem: Path) -> list[str]:
        planner_id, heuristic, search, options = self._selection()
        argv = build_command(ROOT, planner_id, domain, problem, heuristic, search, options)
        if self.extra_var.get().strip():
            argv.extend(shlex.split(self.extra_var.get()))
        return argv

    def _refresh_command_preview(self) -> None:
        try:
            domain = self._domain_path() or Path("DOMAIN.pddl")
            problem = self._problem_path() or Path("PROBLEM.pddl")
            self.command_var.set(shlex.join(self._command(domain, problem)))
        except (ValueError, StopIteration) as error:
            self.command_var.set(str(error))
        except tk.TclError:
            pass

    def _start(self) -> None:
        domain, problem = self._domain_path(), self._problem_path()
        if domain is None or problem is None or not domain.is_file() or not problem.is_file():
            messagebox.showerror("입력 오류", "Domain과 해당 domain의 problem instance를 선택하세요.")
            return
        try:
            timeout = float(self.timeout_var.get())
            cores = int(self.cores_var.get())
            if timeout <= 0 or cores <= 0:
                raise ValueError
            # Validate quoting before creating a run directory.
            self._command(domain.resolve(), problem.resolve())
        except (ValueError, shlex.Error):
            messagebox.showerror("설정 오류", "Timeout/CPU/추가 인자 값을 확인하세요.")
            return

        planner_id = self._selection()[0]
        stamp = datetime.now().strftime("%Y%m%d-%H%M%S-%f")
        run_dir = ROOT / "results" / "gui" / f"{stamp}-{planner_id}"
        work = run_dir / "work"
        work.mkdir(parents=True)
        domain_copy, problem_copy = work / "domain.pddl", work / "problem.pddl"
        shutil.copy2(domain, domain_copy)
        shutil.copy2(problem, problem_copy)
        argv = self._command(domain_copy.resolve(), problem_copy.resolve())
        (run_dir / "command.json").write_text(json.dumps(argv, indent=2) + "\n")

        self.plan_text.delete("1.0", "end")
        self.log_text.delete("1.0", "end")
        self.log_text.insert("end", "$ " + shlex.join(argv) + "\n\n")
        self.last_plan = None
        self.save_button.configure(state="disabled")
        self.plan_button.configure(state="disabled")
        self.cancel_button.configure(state="normal")
        self.status_var.set("실행 중…")
        self.notebook.select(1)
        self.worker = threading.Thread(
            target=self._run_worker,
            args=(planner_id, domain_copy, problem_copy, run_dir, work, argv, timeout, cores, self.validate_var.get()),
            daemon=True,
        )
        self.worker.start()

    def _run_worker(self, planner_id: str, domain: Path, problem: Path, run_dir: Path,
                    work: Path, argv: list[str], timeout: float, cores: int, validate: bool) -> None:
        started = time.monotonic()

        def limits() -> None:
            os.nice(10)
            if hasattr(os, "sched_setaffinity"):
                available = sorted(os.sched_getaffinity(0))
                os.sched_setaffinity(0, set(available[:cores]))

        try:
            self.process = subprocess.Popen(
                argv, cwd=work, text=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
                bufsize=1, start_new_session=True, preexec_fn=limits,
            )
            lines: list[str] = []
            stream: queue.Queue[str] = queue.Queue()
            assert self.process.stdout is not None
            stdout = self.process.stdout

            def read_output() -> None:
                for output_line in iter(stdout.readline, ""):
                    stream.put(output_line)
                stdout.close()

            reader = threading.Thread(target=read_output, daemon=True)
            reader.start()
            timed_out = False
            while self.process.poll() is None or reader.is_alive() or not stream.empty():
                if not timed_out and time.monotonic() - started > timeout and self.process.poll() is None:
                    timed_out = True
                    os.killpg(self.process.pid, signal.SIGTERM)
                    try:
                        self.process.wait(timeout=2)
                    except subprocess.TimeoutExpired:
                        os.killpg(self.process.pid, signal.SIGKILL)
                    self.events.put(("log", f"\n[GUI] timeout after {timeout:g}s\n"))
                try:
                    while True:
                        line = stream.get_nowait()
                        lines.append(line)
                        self.events.put(("log", line))
                except queue.Empty:
                    time.sleep(0.03)
            returncode = self.process.wait()
            elapsed = time.monotonic() - started
            output = "".join(lines)
            (run_dir / "planner.log").write_text(output)
            status = classify(returncode, timed_out, output)
            actions = extract_plan(planner_id, output, domain.read_text(errors="replace"))
            saved = read_saved_actions(work, planner_id)
            if saved:
                actions, status = saved, "solved"
            validation = "not-extracted" if status == "solved" else "not-run"
            plan_path: Path | None = None
            if actions:
                plan_path = run_dir / "plan.val"
                plan_path.write_text(render_plan(actions))
                validation = validate_plan(domain, problem, plan_path, run_dir / "validation.log") if validate else "disabled"
            result = {
                "planner": planner_id, "status": status, "return_code": returncode,
                "wall_seconds": round(elapsed, 4), "plan_length": len(actions),
                "validation": validation, "run_directory": str(run_dir),
            }
            (run_dir / "result.json").write_text(json.dumps(result, indent=2) + "\n")
            self.events.put(("done", (result, plan_path, render_plan(actions) if actions else "")))
        except Exception as error:  # Surface worker failures in the GUI and result folder.
            (run_dir / "gui-error.log").write_text(repr(error) + "\n")
            self.events.put(("error", f"{type(error).__name__}: {error}"))
        finally:
            self.process = None

    def _poll_events(self) -> None:
        try:
            while True:
                kind, payload = self.events.get_nowait()
                if kind == "log":
                    self.log_text.insert("end", str(payload))
                    self.log_text.see("end")
                elif kind == "done":
                    result, plan_path, plan_text = payload
                    self.plan_text.delete("1.0", "end")
                    if plan_text:
                        self.plan_text.insert("end", plan_text)
                        self.notebook.select(0)
                    else:
                        self.plan_text.insert("end", "Plan을 추출하지 못했습니다. 실행 로그를 확인하세요.\n")
                    self.last_plan = plan_path
                    if plan_path:
                        self.save_button.configure(state="normal")
                    self.status_var.set(
                        f"{result['status']} · actions={result['plan_length']} · "
                        f"VAL={result['validation']} · {result['wall_seconds']:.2f}s"
                    )
                    self._finish_controls()
                elif kind == "error":
                    self.status_var.set("실행 오류")
                    self.log_text.insert("end", "\n[GUI ERROR] " + str(payload) + "\n")
                    self._finish_controls()
                    messagebox.showerror("Planner 실행 오류", str(payload))
        except queue.Empty:
            pass
        self.after(self.POLL_MS, self._poll_events)

    def _finish_controls(self) -> None:
        self.plan_button.configure(state="normal")
        self.cancel_button.configure(state="disabled")

    def _cancel(self) -> None:
        process = self.process
        if process and process.poll() is None:
            try:
                os.killpg(process.pid, signal.SIGTERM)
                self.status_var.set("중지 요청됨…")
            except ProcessLookupError:
                pass

    def _save_plan(self) -> None:
        if not self.last_plan or not self.last_plan.is_file():
            return
        destination = filedialog.asksaveasfilename(title="Plan 저장", defaultextension=".plan",
                                                    filetypes=[("Plan", "*.plan"), ("모든 파일", "*")])
        if destination:
            shutil.copy2(self.last_plan, destination)

    def _close(self) -> None:
        if self.process and self.process.poll() is None:
            if not messagebox.askyesno("종료", "Planner가 실행 중입니다. 중지하고 종료할까요?"):
                return
            self._cancel()
        self.destroy()


def main() -> int:
    app = PlannerGUI()
    app.mainloop()
    return 0
