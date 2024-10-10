

import requests
import duckdb
import pandas as pd


def create_database():
    baseUrl = "https://pokeapi.co/api/v2/"

    
    response = requests.get(baseUrl)
    data = response.json()  

   
    conn = duckdb.connect('data/poke_data.db')  

    for key, url in data.items():
        try:
            response = requests.get(url+'?limit=15000&offset=0')
            data = response.json()
            resultData = data['results'] 
            df = pd.DataFrame(resultData) 
            
            
            
            dfData = []

            for url in df['url']:
                 print(url)
                 
                 responseCount = requests.get(url)
                 dataCount = responseCount.json()
                 
                 
                 dfData.append(dataCount)
                
                
            dfTotal = pd.DataFrame(dfData)     
            conn.execute(f'CREATE TABLE IF NOT EXISTS "{key}" AS SELECT * FROM dfTotal')
            
        except requests.exceptions.HTTPError as http_err:
                print(f"HTTP error occurred: {http_err}")
        except Exception as err:
                print(f"An error occurred: {err}")
    

    print("Data successfully fetched and loaded into DuckDB.")
    tables = conn.execute("SELECT table_name FROM information_schema.tables").fetchall()
    
    for table in tables:
        print(table[0])
    conn.close()

create_database()