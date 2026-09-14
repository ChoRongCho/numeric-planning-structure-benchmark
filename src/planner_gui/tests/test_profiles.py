from pathlib import Path
import sys
import unittest

HERE = Path(__file__).resolve()
sys.path.insert(0, str(HERE.parents[1]))
sys.path.insert(0, str(HERE.parents[3] / "scripts" / "run"))

from profiles import GUI_ID_BY_NAME, GUI_PLANNER_NAMES, PROFILE_BY_ID, PROFILES, build_command
from planner_adapters import extract_plan


class ProfileTests(unittest.TestCase):
    def setUp(self):
        self.root = Path("/repo")
        self.domain = Path("/tmp/domain.pddl")
        self.problem = Path("/tmp/problem.pddl")

    def test_profile_ids_are_unique(self):
        self.assertEqual(len(PROFILES), len(PROFILE_BY_ID))
        self.assertEqual(len(PROFILES), 13)

    def test_local_artifacts_have_visible_short_names(self):
        self.assertEqual(GUI_PLANNER_NAMES[:3], ("optic-cplex", "popf", "nfd"))
        self.assertEqual(GUI_ID_BY_NAME["optic-cplex"], "optic-cplex")
        self.assertEqual(GUI_ID_BY_NAME["popf"], "popf-static-v2")
        self.assertEqual(GUI_ID_BY_NAME["nfd"], "numeric-fast-downward-local")

    def test_enhsp_choices_reach_cli(self):
        command = build_command(self.root, "enhsp", self.domain, self.problem,
                                "hmrp", "gbfs", {"helpful": "true", "ties": "larger_g"})
        self.assertIn("hmrp", command)
        self.assertIn("gbfs", command)
        self.assertEqual(command[-4:], ["-ha", "true", "-ties", "larger_g"])

    def test_planforge_recursive_search(self):
        command = build_command(self.root, "planforge-ipc2026", self.domain, self.problem,
                                "lmcutnumeric", "astar", {})
        self.assertIn("astar(lmcutnumeric())", command)

    def test_nfd_recursive_search(self):
        command = build_command(self.root, "numeric-fast-downward-local", self.domain,
                                self.problem, "irhff", "lazy_greedy", {})
        self.assertEqual(command[-2:], ["--search", "lazy_greedy([irhff()])"])

    def test_optic_flags_precede_files(self):
        command = build_command(self.root, "optic-cplex", self.domain, self.problem,
                                "rpg", "best-first", {"helpful": "false", "optimize": "false"})
        self.assertEqual(command[-2:], [str(self.domain), str(self.problem)])
        self.assertIn("-E", command)
        self.assertIn("-h", command)
        self.assertIn("-N", command)

    def test_planforge_colored_plan_is_extracted(self):
        output = (
            "\x1b[32m INFO\x1b[0m Solution found!\n"
            "\x1b[32m INFO\x1b[0m   1: pickup b1 table1\n"
            "\x1b[32m INFO\x1b[0m Plan length: 1 step(s).\n"
        )
        self.assertEqual(
            extract_plan("planforge-ipc2026", output),
            ["(pickup b1 table1)"],
        )


if __name__ == "__main__":
    unittest.main()
