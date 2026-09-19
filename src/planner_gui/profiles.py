"""Planner-specific GUI choices and command construction.

Only options that are wired to the installed command line are exposed.  A
single-item choice means that the corresponding planner configuration is fixed.
"""

from __future__ import annotations

from dataclasses import dataclass
from pathlib import Path


@dataclass(frozen=True)
class Choice:
    label: str
    value: str


@dataclass(frozen=True)
class OptionSpec:
    key: str
    label: str
    choices: tuple[Choice, ...]


@dataclass(frozen=True)
class PlannerProfile:
    planner_id: str
    title: str
    family: str
    description: str
    heuristics: tuple[Choice, ...]
    searches: tuple[Choice, ...]
    options: tuple[OptionSpec, ...] = ()


def choices(*items: tuple[str, str]) -> tuple[Choice, ...]:
    return tuple(Choice(label, value) for label, value in items)


PROFILES: tuple[PlannerProfile, ...] = (
    PlannerProfile(
        "numeric-cegar", "nfd-cegar", "Numeric Fast Downward",
        "Numeric Fast Downward 기반 논문 배포본. A* + Numeric Cartesian CEGAR 구성입니다.",
        choices(("Cartesian CEGAR", "cegar")),
        choices(("A*", "astar")),
        (
            OptionSpec("pick", "Refinement split", choices(
                ("MIN_UNWANTED", "MIN_UNWANTED"),
                ("MAX_UNWANTED", "MAX_UNWANTED"), ("RANDOM", "RANDOM"))),
            OptionSpec("max_time", "Abstraction time (seconds)", choices(
                ("900", "900"), ("60", "60"), ("infinity", "infinity"))),
        ),
    ),
    PlannerProfile(
        "enhsp", "ENHSP", "Numeric subgoaling",
        "Numeric subgoaling/interval relaxation heuristic을 바꿔가며 실행합니다.",
        choices(
            ("hadd — additive subgoaling", "hadd"),
            ("hmax — numeric max", "hmax"),
            ("aibr — interval relaxation", "aibr"),
            ("hradd — hadd + redundant constraints", "hradd"),
            ("hrmax — hmax + redundant constraints", "hrmax"),
            ("hmrp — multi-repetition relaxed plan", "hmrp"),
            ("ngc — numeric goal count", "ngc"),
            ("blcost — goal-sensitive blind", "blcost"),
            ("blind", "blind"),
        ),
        choices(
            ("WA*", "WAStar"), ("GBFS", "gbfs"),
            ("Lazy GBFS", "lazygbfs"), ("WA* (weight 4)", "wa_star_4"),
        ),
        (
            OptionSpec("helpful", "Helpful actions", choices(("기본값", "default"), ("사용", "true"), ("미사용", "false"))),
            OptionSpec("ties", "Tie breaking", choices(("arbitrary", "arbitrary"), ("larger g", "larger_g"), ("smaller g", "smaller_g"))),
        ),
    ),
    PlannerProfile(
        "metric-ff-cross-v1", "Metric-FF", "Numeric RPG / hFF",
        "Metric-FF의 monotonic numeric relaxation과 hFF는 고정입니다.",
        choices(("numeric hFF (고정)", "numeric-hff")),
        choices(("EHC → weighted best-first", "default"), ("Best-first만", "best-first"), ("EHC만", "ehc-only")),
        (OptionSpec("helpful", "Helpful actions", choices(("사용", "true"), ("미사용", "false"))),),
    ),
    PlannerProfile(
        "count-downward-agile", "Count Downward Agile", "Interval-relaxed hFF",
        "IPC agile alias에 search와 interval/repetition hFF가 고정된 구성입니다.",
        choices(("irhff (고정)", "irhff")),
        choices(("lazy_greedy + preferred hFF (고정)", "alias")),
    ),
    PlannerProfile(
        "planforge-ipc2026", "PlanForge IPC 2026", "Optimal numeric heuristics",
        "Numeric LM-cut, PDB, domain abstraction과 cost partitioning을 선택합니다.",
        choices(
            ("numeric LM-cut", "lmcutnumeric"), ("blind", "blind"),
            ("FF", "ff"), ("greedy numeric PDB", "greedy_numeric_pdb"),
            ("canonical numeric PDB", "canonical_numeric_pdb"),
            ("domain abstraction", "domain_abstraction"),
            ("canonical domain abstractions", "canonical_domain_abstractions"),
            ("multiple domain abstractions", "multi_domain_abstractions"),
            ("online saturated cost partitioning", "scp_online"),
            ("fill saturated cost partitioning", "fill_scp"),
        ),
        choices(("A*", "astar"), ("GBFS", "gbfs")),
    ),
    PlannerProfile(
        "patty-ipc2026-agile-1", "PATTY IPC 2026", "Symbolic pattern planning",
        "상태 heuristic 대신 action pattern과 SMT encoding을 사용합니다.",
        choices(("상태 heuristic 없음 (고정)", "none")),
        choices(("JAIR", "jair"), ("A* pattern search", "astar"), ("Step", "step"), ("Static", "static")),
        (
            OptionSpec("pattern", "Pattern", choices(("enhanced", "enhanced"), ("ARPG", "arpg"), ("random", "random"))),
            OptionSpec("solver", "SMT solver", choices(("Z3", "z3"), ("Yices", "yices"))),
            OptionSpec("quality", "Quality", choices(("none", "none"), ("improve CHRPA", "improve-chrpa"))),
        ),
    ),
    PlannerProfile(
        "panino-lnp-agile", "Panino LNP Agile", "Numeric novelty search",
        "IPC 제출본의 novelty partition과 base hadd가 고정된 구성입니다.",
        choices(("hadd + numeric novelty (고정)", "hadd-novelty")),
        choices(("novbfs_hg (고정)", "fixed")),
    ),
    PlannerProfile(
        "tamerlite-ipc2026-agile-1", "TamerLite IPC 2026", "Numeric heuristic search",
        "TamerLite의 delete-relaxation heuristic과 one-shot search를 선택합니다.",
        choices(
            ("hadd", "hadd"), ("hFF", "hff"), ("hmax", "hmax"),
            ("hmax explicit", "hmax_explicit"), ("blind", "blind"),
            ("hadd without numbers", "hadd_no_numbers"),
            ("hFF without numbers", "hff_no_numbers"),
            ("hmax without numbers", "hmax_no_numbers"),
        ),
        choices(("GBFS", "gbfs"), ("Weighted A*", "wastar")),
        (OptionSpec("weight", "Heuristic weight", choices(("1", "1"), ("2", "2"), ("4", "4"), ("5", "5"))),),
    ),
    PlannerProfile(
        "pattint-bitwuzla", "PATTINT", "Bounded bit-vector SMT",
        "상태 heuristic 없이 ARPG pattern과 Bitwuzla bounded encoding을 사용합니다.",
        choices(("상태 heuristic 없음 (고정)", "none")),
        choices(("Bound iterative deepening (고정)", "fixed")),
        (
            OptionSpec("pattern", "Pattern", choices(("ARPG", "arpg"), ("random", "random"))),
            OptionSpec("encoding", "Encoding", choices(("non-linear", "non-linear"), ("binary", "binary"))),
        ),
    ),
    PlannerProfile(
        "tempest-numeric-ipc2026", "Tempest Numeric IPC 2026", "Numeric RPG / hFF",
        "Numeric RPG hFF와 helpful actions를 사용하는 제출 configuration입니다.",
        choices(("numeric hFF (고정)", "numeric-hff")),
        choices(("EHC → A* fallback (고정)", "fixed")),
    ),
    PlannerProfile(
        "optic", "OPTIC (CLP)", "Temporal/numeric RPG",
        "Maintained OPTIC CLP build. Core temporal/numeric RPG는 고정입니다.",
        choices(("temporal/numeric RPG (고정)", "rpg")),
        choices(("EHC → best-first", "default"), ("Best-first만", "best-first"), ("EHC만", "ehc-only")),
        (OptionSpec("helpful", "Helpful actions", choices(("사용", "true"), ("미사용", "false"))),),
    ),
    PlannerProfile(
        "optic-cplex", "OPTIC (local CPLEX)", "Temporal/numeric RPG",
        "사용자 제공 CPLEX-linked OPTIC binary. Core heuristic은 고정입니다.",
        choices(("temporal/numeric RPG (고정)", "rpg")),
        choices(("EHC → best-first", "default"), ("Best-first만", "best-first"), ("EHC만", "ehc-only")),
        (
            OptionSpec("helpful", "Helpful actions", choices(("사용", "true"), ("미사용", "false"))),
            OptionSpec("optimize", "Plan quality", choices(("최적화", "true"), ("첫 plan", "false"))),
        ),
    ),
    PlannerProfile(
        "popf-static-v2", "POPF Release 2 (local)", "Temporal/numeric RPG",
        "사용자 제공 static POPF. Sandbox에서는 32-bit seccomp로 막힐 수 있습니다.",
        choices(("temporal/numeric RPG (고정)", "rpg")),
        choices(("EHC → best-first", "default"), ("Best-first만", "best-first"), ("EHC만", "ehc-only")),
        (
            OptionSpec("helpful", "Helpful actions", choices(("사용", "true"), ("미사용", "false"))),
            OptionSpec("optimize", "Plan quality", choices(("첫 plan", "false"), ("anytime 최적화", "true"))),
        ),
    ),
    PlannerProfile(
        "numeric-fast-downward-local", "Numeric Fast Downward (local)", "Numeric heuristic search",
        "수정된 로컬 NFD에서 numeric heuristic과 search를 직접 선택합니다.",
        choices(
            ("numeric LM-cut", "lmcutnumeric"), ("AIBR", "aibr"),
            ("interval hmax", "iihmax"), ("interval hadd", "iihadd"),
            ("interval hFF", "iihff"), ("repetition hmax", "irhmax"),
            ("repetition hadd", "irhadd"), ("repetition hFF", "irhff"),
            ("numeric PDB", "numeric_pdb"),
        ),
        choices(("A*", "astar"), ("Lazy greedy", "lazy_greedy")),
    ),
)


PROFILE_BY_ID = {profile.planner_id: profile for profile in PROFILES}

# Stable internal IDs preserve benchmark reproducibility, while the GUI uses the
# short names by which the local artifacts are actually known to the user.
GUI_NAME_BY_ID = {
    "optic-cplex": "optic-cplex",
    "popf-static-v2": "popf",
    "numeric-fast-downward-local": "nfd",
    "numeric-cegar": "nfd-cegar",
}
GUI_ID_BY_NAME = {
    GUI_NAME_BY_ID.get(profile.planner_id, profile.planner_id): profile.planner_id
    for profile in PROFILES
}
GUI_PLANNER_NAMES = (
    "optic-cplex",
    "popf",
    "nfd",
    *(GUI_NAME_BY_ID.get(profile.planner_id, profile.planner_id) for profile in PROFILES
      if profile.planner_id not in {"optic-cplex", "popf-static-v2", "numeric-fast-downward-local"}),
)


def _flag(options: dict[str, str], key: str, expected: str) -> bool:
    return options.get(key) == expected


def build_command(
    root: Path,
    planner_id: str,
    domain: Path,
    problem: Path,
    heuristic: str,
    search: str,
    options: dict[str, str],
) -> list[str]:
    """Build an argv list for one installed planner configuration."""
    ctl = str(root / "planners" / "plannerctl")
    d, p = str(domain), str(problem)
    base = [ctl, "run", planner_id]

    if planner_id == "enhsp":
        argv = base + ["-o", d, "-f", p, "-h", heuristic, "-s", search]
        if options.get("helpful") != "default":
            argv += ["-ha", options["helpful"]]
        if options.get("ties"):
            argv += ["-ties", options["ties"]]
        return argv
    if planner_id == "metric-ff-cross-v1":
        argv = base + ["-o", d, "-f", p]
        if search == "best-first":
            argv.append("-E")
        elif search == "ehc-only":
            argv.append("-b")
        if _flag(options, "helpful", "false"):
            argv.append("-h")
        return argv
    if planner_id == "planforge-ipc2026":
        return base + ["--search", f"{search}({heuristic}())", d, p]
    if planner_id == "patty-ipc2026-agile-1":
        argv = base + [
            "-o", d, "-f", p, "-s", search,
            "--pattern", options.get("pattern", "enhanced"),
            "--solver", options.get("solver", "z3"),
            "--quality", options.get("quality", "none"),
        ]
        if search == "jair":
            argv += ["--jair-search-strategy", "B", "--jair-goal-function", "n",
                     "--jair-pattern-g", "p", "--jair-pattern-h", "c"]
        return argv
    if planner_id == "tamerlite-ipc2026-agile-1":
        return base + [d, p, search, heuristic, options.get("weight", "1")]
    if planner_id == "pattint-bitwuzla":
        return base + [
            "--solver", "bitwuzla", "-o", d, "-f", p,
            "--save-plan", "pattint.plan", "-v", "0",
            "--pattern", options.get("pattern", "arpg"),
            "--encoding", options.get("encoding", "non-linear"),
        ]
    if planner_id in {"optic", "optic-cplex", "popf-static-v2"}:
        argv = base
        if search == "best-first":
            argv.append("-E")
        elif search == "ehc-only":
            argv.append("-b")
        if _flag(options, "helpful", "false"):
            argv.append("-h")
        if planner_id == "optic-cplex" and _flag(options, "optimize", "false"):
            argv.append("-N")
        if planner_id == "popf-static-v2" and _flag(options, "optimize", "true"):
            argv.append("-n")
        return argv + [d, p]
    if planner_id == "numeric-cegar":
        pick = options.get("pick", "MIN_UNWANTED")
        max_time = options.get("max_time", "900")
        return base + [d, p, "--search",
                       f"astar(cegar(subtasks=[original()],pick={pick},max_time={max_time}))"]
    if planner_id == "numeric-fast-downward-local":
        spec = f"{search}({heuristic}())" if search == "astar" else f"lazy_greedy([{heuristic}()])"
        return base + [d, p, "--search", spec]
    if planner_id in {"count-downward-agile", "panino-lnp-agile", "tempest-numeric-ipc2026"}:
        return base + [d, p]
    raise ValueError(f"Unsupported GUI planner: {planner_id}")
