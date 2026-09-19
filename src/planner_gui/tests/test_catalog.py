from pathlib import Path
import sys
import unittest
import tempfile

HERE = Path(__file__).resolve()
ROOT = HERE.parents[3]
sys.path.insert(0, str(HERE.parents[1]))

from catalog import discover_catalog


class CatalogTests(unittest.TestCase):
    def test_paper_layout_lists_problems_beside_domain(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            folder = root / "benchmarks-oo" / "counters"
            folder.mkdir(parents=True)
            for name in ("domain.pddl", "pfile10.pddl", "pfile2.pddl"):
                (folder / name).write_text("")
            entries = discover_catalog(root)
            self.assertEqual(len(entries), 1)
            self.assertEqual(entries[0].collection, "numeric-cegar-paper")
            self.assertEqual([p.name for p in entries[0].problems],
                             ["pfile2.pddl", "pfile10.pddl"])

    def test_merges_both_collections_and_counts_instances(self):
        entries = discover_catalog(ROOT)
        by_key = {(entry.collection, entry.domain.parent.name): entry for entry in entries}
        self.assertIn(("benchmarks", "03_BLOCKSWORLD"), by_key)
        self.assertIn(("changmin", "01_blocksworld"), by_key)
        self.assertEqual(len(by_key[("benchmarks", "03_BLOCKSWORLD")].problems), 3)
        self.assertEqual(len(by_key[("changmin", "01_blocksworld")].problems), 5)

    def test_only_existing_pddl_instances_are_listed(self):
        for entry in discover_catalog(ROOT):
            for problem in entry.problems:
                self.assertTrue(problem.is_file())
                self.assertTrue(problem.name.startswith("p"))
                self.assertEqual(problem.suffix, ".pddl")


if __name__ == "__main__":
    unittest.main()
