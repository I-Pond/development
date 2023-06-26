import pandas as pd 
import numpy as np 
import psycopg2 
import pyrebase
import pandas as pd
from dbs import *
from datetime import datetime

try : 
    #firebase
    firebase = pyrebase.initialize_app(config23)
    db =firebase.database()
    #postgre
    conn = psycopg2.connect(f"dbname={db_pos['DB_NAME']} user={db_pos['user']} password={db_pos['password']}")
    cur = conn.cursor()
    query = """INSERT INTO datair (tanggal,ph,temperature,turbidity) VALUES (%s,%s,%s,%s)"""
    firebase_data = list(db.child("Prototype").child('Ipone').get().val().values()) # NANTI BENARKAN CHILDNYA TAKUTNYA LANGSUNG PROTOTYPE DAN TEST ATAU NGUBAH NAMANYA.
    for i in firebase_data:
        TIMESTAMP_TEMP = i['Tanggal'] +" "+i['Waktu']
        datetime_convert = datetime.strptime(TIMESTAMP_TEMP,'%A,%d-%B-%Y %H:%M:%S')
        data = (datetime_convert,float(i['ph']), float(i['Temperature']), float(i['Turbinity'])) # tinggal tambahin depan float ada datime_convert,float
        cur.execute(query,data)
        conn.commit()
        print("Record inserted successfully into mobile table")
        
except Exception as error:
    print(error)