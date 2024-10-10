import duckdb
import pandas as pd

import requests

conn = duckdb.connect('poke_data.db')  
 
    
berry = conn.execute("SELECT * FROM stg_berries").fetchdf()

print(berry)

conn.close()
