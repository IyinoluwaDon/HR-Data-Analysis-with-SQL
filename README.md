# HR Data Analysis with SQLite and SQL

A read-only analysis of the supplied HR database. Twelve named SQL queries summarize the workforce and export review-ready CSV tables; integrity and foreign-key checks run before the analysis. Tenure calculations use explicit review dates.

`abc_inc_hr.db` is the supplied database, `queries/analysis.sql` contains the analyses, and `run_analysis.py` writes CSV and JSON results to the chosen output folder.

## Reproduce the outputs

```sh
python run_analysis.py --output-dir results
```

The results describe the records in this SQLite database and preserve the source database unchanged.
