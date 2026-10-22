"""Run the checked-in SELECT queries without modifying the supplied database."""
from pathlib import Path
import argparse, csv, json, sqlite3

ROOT=Path(__file__).resolve().parent

def analyze(output_dir):
    output_dir=Path(output_dir);output_dir.mkdir(parents=True,exist_ok=True)
    database=(ROOT/'abc_inc_hr.db').as_uri()+'?mode=ro'
    results={}
    with sqlite3.connect(database,uri=True) as connection:
        assert connection.execute('PRAGMA integrity_check').fetchone()[0]=='ok', 'Database is damaged'
        assert not connection.execute('PRAGMA foreign_key_check').fetchall(), 'Broken review references'
        sql=(ROOT/'queries/analysis.sql').read_text(encoding='utf-8')
        for block in sql.split('-- name: ')[1:]:
            name,query=block.split('\n',1)
            cursor=connection.execute(query)
            columns=[c[0] for c in cursor.description];rows=cursor.fetchall()
            results[name]={'columns':columns,'rows':rows}
            with (output_dir/f'{name}.csv').open('w',newline='',encoding='utf-8') as f:
                writer=csv.writer(f);writer.writerow(columns);writer.writerows(rows)
    (output_dir/'summary.json').write_text(json.dumps(results,indent=2),encoding='utf-8')
    return results

if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('--output-dir',type=Path,default=ROOT/'results')
    args=parser.parse_args();results=analyze(args.output_dir)
    print(f'Validated database and wrote {len(results)} query results to {args.output_dir}')
