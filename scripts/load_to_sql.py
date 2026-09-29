import os
import pandas as pd
from sqlalchemy import create_engine
from dotenv import load_dotenv

load_dotenv()

df = pd.read_csv("data/cleaned/phishing_cleaned.csv")

engine = create_engine(
    f"mysql+pymysql://{os.getenv('DB_USER')}:{os.getenv('DB_PASSWORD')}"
    f"@{os.getenv('DB_HOST')}/phishing_analytics"
)

df.to_sql(
    name="websites",
    con=engine,
    if_exists="replace",
    index=False,
    chunksize=5000
)

print("Data successfully loaded into MySQL.")
print(f"Rows loaded: {len(df)}")