import unittest

from delayed_conflict_domain_micro import (
    COSTS,
    logistics_problem,
    manifestation_depth,
    watering_problem,
)


class DomainMicroTest(unittest.TestCase):
    def test_cost_permutation_holds_total_constant_and_moves_failure(self):
        self.assertEqual(sum(COSTS["early"]), sum(COSTS["deep"]))
        self.assertEqual(manifestation_depth(COSTS["early"]), 2)
        self.assertEqual(manifestation_depth(COSTS["deep"]), 4)

    def test_watering_uses_original_domain_and_numeric_moves(self):
        text = watering_problem("deep", 2)
        self.assertIn("(:domain robotic-watering)", text)
        self.assertIn("(= (battery-level robot1) 10)", text)
        self.assertEqual(text.count("(connected n0 side0_"), 2)

    def test_logistics_uses_original_domain_and_no_refuel_station(self):
        text = logistics_problem("early", 0)
        self.assertIn("(:domain logistic)", text)
        self.assertIn("(loaded pack1 truck1)", text)
        self.assertNotIn("(fuel-station", text)


if __name__ == "__main__":
    unittest.main()
