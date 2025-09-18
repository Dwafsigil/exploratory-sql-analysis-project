import os
from dotenv import load_dotenv
from sqlalchemy import create_engine, text
import pandas as pd

# Load environment variables
load_dotenv()

DB_PATH = os.getenv('DB_PATH', './data/database.db')  # fallback to default
DB_URL = f'sqlite:///{DB_PATH}'

def connect():
    try:
        engine = create_engine(DB_URL)
        # Optional: verify file & show absolute path
        print(f"DB file: {os.path.abspath(DB_PATH)}")
        with engine.connect() as conn:
            # Good practice for SQLite if you use FKs
            conn.execute(text("PRAGMA foreign_keys=ON;"))
        print("✅ Connected to SQLite.")
        return engine
    except Exception as e:
        print(f"❌ Error connecting to database: {e}")
        return None

def is_select_like(sql: str) -> bool:
    s = sql.lstrip().lower()
    return s.startswith(("select", "with", "pragma", "show", "explain"))

def run_queries_from_file(engine, filepath):
    try:
        with open(filepath, 'r', encoding='utf-8') as file:
            content = file.read()
        queries = [q.strip() for q in content.split(';') if q.strip()]

        for i, query in enumerate(queries, start=0):
            # Skip full-line SQL comments
            if query.startswith('--') or not any(c.isalnum() for c in query):
                continue

            print(f"\n🔎 Query {i}:\n{query}")
            try:
                if is_select_like(query):
                    # READ path: returns rows
                    df = pd.read_sql(query, con=engine)
                    print(df)
                else:
                    # WRITE path: INSERT/UPDATE/DELETE/DDL — commit explicitly
                    with engine.begin() as conn:  # begins a tx and commits on success
                        conn.execute(text(query))
                    print("✅ Statement executed and committed.")
            except Exception as e:
                print(f"❌ Error in Query {i}: {e}")
    except Exception as e:
        print(f"❌ Error processing queries from {filepath}: {e}")

if __name__ == "__main__":
    engine = connect()
    if engine:
        run_queries_from_file(engine, './src/sql/queries.sql')