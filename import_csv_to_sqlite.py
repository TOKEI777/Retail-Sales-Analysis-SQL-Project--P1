import sqlite3
import pandas as pd

CSV_PATH = "SQL - Retail Sales Analysis_utf .csv"
DB_PATH = "retail_sales.db"
TABLE = "retail_sales"

# 读 CSV
df = pd.read_csv(CSV_PATH)

# 连接 SQLite
conn = sqlite3.connect(DB_PATH)

# 写入表（append 到你刚创建的表）
df.to_sql(TABLE, conn, if_exists="append", index=False)

# 验证
cur = conn.cursor()
cur.execute(f"SELECT COUNT(*) FROM {TABLE};")
print("Rows inserted:", cur.fetchone()[0])

conn.close()
print("Done")