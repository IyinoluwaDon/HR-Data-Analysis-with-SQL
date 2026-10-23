# HR Data Analysis with SQLite

A read-only descriptive analysis of a bundled SQLite HR database. Named SQL queries export summary tables for review without modifying the source database.

## What is included

- Twelve repeatable SQL analyses and CSV exports
- Database integrity and foreign-key validation
- Tenure calculations anchored to review dates

## Run locally

```sh
python run_analysis.py --output-dir results
```

## Verify

The analysis validates SQLite integrity and foreign keys before exporting. Run `python run_analysis.py --output-dir results` to reproduce all query outputs.

## Repository map

`abc_inc_hr.db` is the supplied database. `queries/analysis.sql` contains the named read-only queries. `run_analysis.py` writes CSV and JSON summaries to the selected output directory.

## Evidence and limitations

All twelve exports were generated and database integrity checks passed. The results describe this supplied database only.

The dataset's source, license, collection process and definitions are not documented. Attrition-related findings are descriptive and do not demonstrate causal effects or predict employee behavior. Keep any derived data subject to the same privacy controls as the source.

## License

No repository license file is included. Unless the project owner adds a license, do not assume the code, data or model artifacts may be redistributed or reused. Verify third-party data and model terms separately.
