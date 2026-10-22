# HR analysis with SQLite

A reproducible descriptive analysis of the supplied `abc_inc_hr.db`: 1,000 employees and 1,000 performance-review rows. The project examines headcount, salaries in BDT, recorded review scores, bonus estimates, reporting spans, tenure, and the database's attrition-risk labels.

## Reproduce

Use Python 3.10 or newer and run `python run_analysis.py`. No external packages are required. The runner opens the database read-only, checks database integrity and review foreign keys, and writes twelve CSV results plus `results/summary.json`. The complete queries are in `queries/analysis.sql`; they can also be run in DB Browser for SQLite. `--output-dir` selects a different result folder.

Tenure is measured at each review's end date. It no longer changes simply because the query runs in a later calendar year. The DB Browser project uses the same date basis and opens the source database read-only.

## Interpretation

Engineering has the largest headcount (238), while Product has the highest mean monthly salary in this sample. The database labels 712 review rows as high attrition risk; these are supplied labels, not observed departures or validated predictions. They do not establish a need for action against an individual employee. Manager and peer score averages are descriptive and do not prove review fairness.

Null reporting-manager values do not establish that the affected staff are senior leaders. `data_quality.csv` and `missing_manager_references.csv` make the checks explicit. Bonus calculations multiply monthly salary by the recorded fractional bonus field; an annual bonus policy is not provided.

## Data provenance and limits

The original files do not document the database source, license, sampling process, or how attrition labels were assigned. The database contains names and compensation fields; do not assume it is anonymized or synthetic. The analysis outputs intentionally omit employee names. This is an exploratory portfolio analysis, not a causal study or a predictive employee-scoring system.
