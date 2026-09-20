import tempfile
import unittest
from pathlib import Path

from analyze_delayed_conflict_evidence import parse_metric_ff_evaluated, safe_ratio


class DelayedConflictEvidenceTest(unittest.TestCase):
    def test_metric_ff_evaluated_uses_last_summary(self):
        with tempfile.TemporaryDirectory() as directory:
            log = Path(directory) / "planner.log"
            log.write_text(
                "intermediate evaluating 12 states\n"
                "0.10 seconds searching, evaluating 49047 states, to a max depth of 12\n"
            )
            self.assertEqual(parse_metric_ff_evaluated(log), 49047)

    def test_metric_ff_evaluated_handles_missing_summary(self):
        with tempfile.TemporaryDirectory() as directory:
            log = Path(directory) / "planner.log"
            log.write_text("no search summary\n")
            self.assertIsNone(parse_metric_ff_evaluated(log))

    def test_safe_ratio(self):
        self.assertEqual(safe_ratio(30, 10), 3.0)
        self.assertIsNone(safe_ratio(None, 10))
        self.assertIsNone(safe_ratio(10, 0))


if __name__ == "__main__":
    unittest.main()
