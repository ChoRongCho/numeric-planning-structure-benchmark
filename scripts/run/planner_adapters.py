"""Command construction and output normalization for benchmarkctl."""

from __future__ import annotations

import re
from pathlib import Path


def command(root: Path, planner: str, domain: Path, problem: Path) -> list[str]:
    ctl = str(root / "planners" / "plannerctl")
    d, p = str(domain), str(problem)
    if planner in {"metric-ff", "metric-ff-2.0", "metric-ff-cross-v1", "metric-ff-cross-v2", "ferroplan"}:
        argv = [ctl, "run", planner, "-o", d, "-f", p]
        if planner in {"metric-ff", "metric-ff-2.0", "metric-ff-cross-v2"} and "(:metric" not in problem.read_text(errors="replace").lower():
            argv.extend(["-s", "0"])
        return argv
    if planner in {"planforge", "planforge-ipc2026"}:
        return [ctl, "run", planner, "--search", "astar(lmcutnumeric())", d, p]
    if planner in {"enhsp", "patty", "springroll"}:
        return [ctl, "run", planner, "-o", d, "-f", p]
    if planner in {"popf", "popf-static-v2", "optic", "optic-cplex"}:
        return [ctl, "run", planner, d, p]
    if planner == "tempest-numeric-ipc2026":
        return [ctl, "run", planner, d, p]
    if planner in {"numeric-fast-downward", "numeric-fast-downward-local"}:
        return [ctl, "run", planner, d, p, "--search", "astar(lmcutnumeric)"]
    if planner.startswith("lnm-plan-") and planner != "lnm-plan-ipc2023":
        return [ctl, "run", planner, d, p]
    if planner.startswith("nplanning-lnp-"):
        return [ctl, "run", planner, d, p]
    if planner.startswith("count-downward-"):
        return [ctl, "run", planner, d, p]
    if planner in {"tempest", "tempest-opt"}:
        return [ctl, "run", planner, d, p]
    if planner.startswith("patty-ipc2026-"):
        strategy_b = planner.endswith("-1")
        quality = "improve-chrpa" if "-sat-" in planner else "none"
        return [
            ctl, "run", planner, "-o", d, "-f", p, "-s", "jair",
            "--pattern", "enhanced", "--quality", quality,
            "--jair-search-strategy", "B" if strategy_b else "G",
            "--jair-goal-function", "n",
            "--jair-pattern-g", "p" if strategy_b else "e",
            "--jair-pattern-h", "c" if strategy_b else "i",
        ]
    if planner in {"panino-lnp-agile", "panino-lnp-sat"}:
        return [ctl, "run", planner, d, p]
    if planner == "pattint-bitwuzla":
        return [
            ctl, "run", planner, "--solver", "bitwuzla", "-o", d, "-f", p,
            "--save-plan", "pattint.plan", "-v", "0",
        ]
    if planner.startswith("tamerlite-ipc2026-"):
        return [ctl, "run", planner, d, p]
    if planner in {"tamerlite", "nextflap", "crikey2"}:
        return [ctl, "run", planner, d, p]
    if planner == "omtplan":
        return [ctl, "run", planner, "-omt", "-parallel", "-domain", d, p]
    if planner in {"lpg-td", "up-lpg-native"}:
        return [ctl, "run", planner, "-o", d, "-f", p, "-n", "1"]
    raise ValueError(f"No PDDL adapter for planner: {planner}")


def classify(returncode: int | None, timed_out: bool, output: str) -> str:
    lower = output.lower()
    if timed_out:
        return "timeout"
    if "some syntax error" in lower or "parseexception" in lower:
        return "parse-error"
    solved = (
        "found legal plan",
        "problem solved",
        "solved_satisficing",
        "the plan is valid",
        "plan is valid",
        "solved: true",
        "solution found:",
        "solution found!",
        "plan computed:",
        "search: solved",
    )
    if (
        any(token in lower for token in solved)
        or re.search(r"^\s*\d+(?:\.\d+)?:\s*\(", output, re.M)
        or re.search(r"^Plan \(\d+ actions?\):", output, re.M)
    ):
        return "solved"
    if any(token in lower for token in ("unsolvable problem", "no plan found", "unsolvable")):
        return "unsolved"
    if returncode not in (0, None):
        return "crash"
    return "unknown"


def _call(name: str, args: str) -> str:
    values = [value.strip() for value in args.split(",") if value.strip()]
    return "(" + " ".join([name.strip()] + values) + ")"


def extract_plan(planner: str, output: str, domain_text: str = "") -> list[str]:
    actions: list[str] = []
    if planner in {"metric-ff", "metric-ff-cross-v1", "metric-ff-cross-v2", "ferroplan"}:
        active = False
        for line in output.splitlines():
            if "found legal plan as follows" in line.lower():
                active = True
                continue
            if active:
                match = re.match(r"\s*(?:step\s+)?(\d+):\s*(.+?)\s*$", line, re.I)
                if match:
                    action = match.group(2).strip()
                    actions.append(action if action.startswith("(") else f"({action})")
                elif actions and line.strip() and not re.match(r"\s*\d+:", line):
                    break
    elif planner == "metric-ff-2.0":
        inside = False
        for line in output.splitlines():
            if "STARTPLANSTARTPLANSTARTPLAN" in line:
                inside = True
            elif "ENDPLANENDPLANENDPLAN" in line:
                break
            elif inside:
                match = re.match(r"\s*\d+:\s*(\(.*\))", line)
                if match:
                    actions.append(match.group(1))
    elif planner in {"enhsp", "patty", "panino-lnp-agile", "panino-lnp-sat"}:
        actions = [m.group(1) for m in re.finditer(r"^\s*\d+(?:\.\d+)?:\s*(\([^\n]+\))\s*$", output, re.M)]
    elif planner in {"tamerlite", "tempest", "tempest-opt"}:
        inside = False
        for line in output.splitlines():
            if line.strip() == "SequentialPlan:":
                inside = True
                continue
            if inside:
                match = re.match(r"\s+([A-Za-z_][\w-]*)\(([^)]*)\)\s*$", line)
                if match:
                    actions.append(_call(match.group(1), match.group(2)))
                elif line.strip():
                    if actions:
                        break
    elif planner == "omtplan":
        declared = re.findall(r"\(\s*:action\s+([^\s()]+)", domain_text, re.I)
        inside = False
        for line in output.splitlines():
            if line.strip() == "SequentialPlan:":
                inside = True
                continue
            token = line.strip()
            if inside and re.fullmatch(r"[A-Za-z_][\w-]*", token):
                candidates = [name for name in declared if token.lower() == name.lower() or token.lower().startswith(name.lower() + "_")]
                if candidates:
                    name = max(candidates, key=len)
                    suffix = token[len(name):].lstrip("_")
                    params = suffix.split("_") if suffix else []
                    actions.append("(" + " ".join([name] + params) + ")")
                else:
                    actions.append("(" + token.replace("_", " ") + ")")
            elif inside and token and actions:
                break
    elif planner == "nextflap":
        rows = []
        for match in re.finditer(r"^\s*(\d+)\)\s*([A-Za-z_][\w-]*)\(([^)]*)\)", output, re.M):
            rows.append((int(match.group(1)), _call(match.group(2), match.group(3))))
        actions = [action for _, action in sorted(rows)]
    elif planner in {"lpg-td", "up-lpg-native", "crikey2"}:
        for match in re.finditer(r"^\s*(\d+(?:\.\d+)?):\s*(\([^\n]+?\))\s*(?:\[D:?(\d+(?:\.\d+)?)[^]]*\]|\[(\d+(?:\.\d+)?)\])", output, re.M | re.I):
            duration = match.group(3) or match.group(4)
            actions.append(f"{match.group(1)}: {match.group(2)} [{duration}]")
    elif planner in {"popf", "popf-static-v2", "optic", "optic-cplex"}:
        # OPTIC may print an incumbent and then the final solution.  Only the
        # final Solution Found section is a plan to validate.
        final = output.rsplit(";;;; Solution Found", 1)[-1]
        temporal_domain = ":durative-action" in domain_text.lower()
        for match in re.finditer(
            r"^\s*(\d+(?:\.\d+)?):\s*(\([^\n]+?\))\s*\[(\d+(?:\.\d+)?)\]",
            final, re.M,
        ):
            if temporal_domain:
                actions.append(f"{match.group(1)}: {match.group(2)} [{match.group(3)}]")
            else:
                # POPF assigns epsilon timestamps even to instantaneous PDDL.
                # VAL requires these actions to be serialized for a classical
                # domain, while preserving their printed order.
                actions.append(match.group(2))
    elif planner in {"planforge", "planforge-ipc2026"}:
        # The IPC build may wrap the INFO prefix in ANSI color sequences.
        plain = re.sub(r"\x1b\[[0-9;]*m", "", output)
        final = plain.split("Solution found!", 1)[-1]
        for match in re.finditer(r"\bINFO\s+\d+:\s+([^\n]+)", final):
            action = match.group(1).strip()
            if action.lower().startswith("plan length:"):
                break
            actions.append(f"({action})")
    elif planner == "tempest-numeric-ipc2026":
        inside = False
        for line in output.splitlines():
            if re.match(r"^Plan \(\d+ actions?\):", line):
                inside = True
                continue
            if inside:
                match = re.match(r"^\s+(\([^\n]+\))\s*$", line)
                if match:
                    actions.append(match.group(1))
                elif actions and line.strip():
                    break
    elif planner.startswith("nplanning-lnp-"):
        final = output.split(";;;; NPlanning Plan", 1)[-1]
        actions = [
            line.strip() for line in final.splitlines()
            if line.strip().startswith("(") and line.strip().endswith(")")
        ]
    elif planner.startswith("patty-ipc2026-"):
        inside = False
        for line in output.splitlines():
            if line.startswith("Bound:"):
                inside = True
                continue
            token = line.strip()
            if inside and re.fullmatch(r"[a-z][\w-]*(?:\s+[\w-]+)*", token):
                actions.append(f"({token})")
            elif inside and actions and token:
                break
    elif planner == "springroll":
        for match in re.finditer(r"Action Name:([^\s]+)\s+Parameters:\s*([^\n]*)", output):
            params = [part for part in match.group(2).split() if not part.startswith("-")]
            actions.append("(" + " ".join([match.group(1)] + params) + ")")
    return actions


def render_plan(actions: list[str]) -> str:
    if actions and re.match(r"^\d+(?:\.\d+)?:", actions[0]):
        return "\n".join(actions) + "\n"
    return "\n".join(f"{index}: {action}" for index, action in enumerate(actions)) + "\n"


def metric_value(output: str) -> str:
    patterns = (
        r"Metric \(Search\):\s*([-+0-9.eE]+)",
        r"plan cost:\s*([-+0-9.eE]+)",
        r"METRIC_VALUE\s*=\s*([-+0-9.eE]+)",
        r"Plan quality:\s*([-+0-9.eE]+)",
        r"Cost:\s*([-+0-9.eE]+)",
    )
    for pattern in patterns:
        match = re.search(pattern, output, re.I)
        if match:
            return match.group(1)
    return ""
