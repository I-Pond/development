from fastapi import FastAPI, Body
from pydantic import BaseModel
import uvicorn
import pandas as pd
import joblib 
import yaml 
import psycopg2
from src.dbs import db_postgre

with open('/myipond/config/config.yaml','r') as file:
    config = yaml.safe_load(file)

model = joblib.load('/myipond/model.pkl')

POSTGRES_USER = db_postgre['user']
POSTGRES_PASSWORD = db_postgre['password']
POSTGRES_SERVER = db_postgre['host']
POSTGRES_PORT = db_postgre['port']
POSTGRES_DB = db_postgre['DB_NAME']

conn = psycopg2.connect(
    host=POSTGRES_SERVER,
    port=POSTGRES_PORT,
    dbname=POSTGRES_DB,
    user=POSTGRES_USER,
    password=POSTGRES_PASSWORD
)
class api_data(BaseModel):
    hujan : int
    kelembabpan : int
    tekanan_udara : float
    temperature : int
    tingkat_cahaya : int
    
app = FastAPI()

@app.get('/')
async def home():
    return 'Hello, Fast Api Berhasillll....'

@app.post('/predict/')
async def predict (data:api_data):
    try:
        print(data)
        data = pd.DataFrame(data).set_index(0).T.reset_index(drop=True)
        data.columns = config['predictors']
    
        y_pred = model.predict(data)
        print(y_pred)
        return str(y_pred) 
    except Exception as e:
        return 'Your data is not going anywhere'
if __name__ == '__main__':
    uvicorn.run("app:app", host= "localhost", port=5000,reload=True)

#KALAU MAU LATIHAN AMBIL API BISA DI NONAKTIFKAN ATAU DICOMAND YANG BAGIAN POSTGRES