from __future__ import annotations

import tempfile
import unittest
from pathlib import Path

from delayed_conflict_experiment import (
    build_graph,
    exact_oracle,
    reference_analysis,
    variants,
    write_oracle_traces,
    write_pddl,
)


class DelayedConflictExperimentTests(unittest.TestCase):
    def setUp(self):
        self.variants = variants(depth=6, high_branching=3, initial_fuel=2)
        self.by_name = {variant.name: variant for variant in self.variants}

    def test_revelation_depth_is_controlled(self):
        self.assertEqual(self.by_name["early-low"].manifestation_depth, 3)
        self.assertEqual(self.by_name["early-high"].manifestation_depth, 3)
        self.assertEqual(self.by_name["deep-low"].manifestation_depth, 6)
        self.assertEqual(self.by_name["deep-high"].manifestation_depth, 6)

    def test_oracle_has_valid_good_action_and_invalid_bad_actions(self):
        for variant in self.variants:
            oracle = exact_oracle(build_graph(variant))
            self.assertTrue(oracle["initial_solvable"])
            self.assertTrue(all(row["successor_solvable"] for row in oracle["good_root_actions"]))
            self.assertTrue(all(not row["successor_solvable"] for row in oracle["bad_root_actions"]))

    def test_depth_and_branching_increase_false_feasible_search(self):
        results = {}
        for variant in self.variants:
            graph = build_graph(variant)
            results[variant.name] = reference_analysis(graph, exact_oracle(graph))
        self.assertGreater(
            results["deep-low"]["false_finite_states"],
            results["early-low"]["false_finite_states"],
        )
        self.assertGreater(
            results["deep-high"]["false_finite_states"],
            results["deep-low"]["false_finite_states"],
        )
        self.assertGreater(
            results["deep-high"]["reference_gbfs_expanded"],
            results["early-low"]["reference_gbfs_expanded"],
        )

    def test_generated_pddl_contains_numeric_resource(self):
        graph = build_graph(self.by_name["deep-low"])
        with tempfile.TemporaryDirectory() as temporary:
            domain, problem = write_pddl(graph, Path(temporary))
            self.assertIn("(decrease (fuel) (edge-cost ?from ?to))", domain.read_text())
            self.assertIn("(edge-cost root", problem.read_text())
            self.assertIn("(:metric minimize (total-cost))", problem.read_text())

    def test_oracle_trace_marks_false_finite_states(self):
        graph = build_graph(self.by_name["deep-high"])
        oracle = exact_oracle(graph)
        with tempfile.TemporaryDirectory() as temporary:
            output = Path(temporary)
            write_oracle_traces(graph, oracle, output)
            rows = (output / "oracle_states.csv").read_text().splitlines()
            self.assertTrue(any(",true," in row for row in rows[1:]))
            self.assertTrue((output / "oracle_actions.csv").is_file())


if __name__ == "__main__":
    unittest.main()
