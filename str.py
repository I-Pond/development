import streamlit as st
import pandas as pd
import joblib
import pyrebase
from src.dbs import config_dt_streamlit
from datetime import datetime

# load the pre-trained model and scaler
model = joblib.load('modelss5.pkl')

def predict_weather(turbinity,temperature,ph):
    # create a dataframe with the user input
    input_data = pd.DataFrame([[turbinity,temperature,ph]], 
                              columns=['ph','temperature','turbinity'])
    # make predictions
    prediction = model.predict(input_data)
    return prediction[0]

firebase = pyrebase.initialize_app(config_dt_streamlit)
db = firebase.database()
# current_date = datetime.now().strftime("%Y-%m-%d %H:%M:%S" )
current_date = datetime.now()
waktu_sekrng = current_date.strftime("%H:%M:%S")

st.title('Water Quality Sensor For Nila Fisherman')
st.header('Input hasil dari data IoT untuk dapat memberikan hasil kekeruhan: ')
turbinity = st.number_input('Masukin Tingkat Kekeruhan:')
ph = st.number_input('Masukin Ph:')
temperature = st.number_input('Masukin Temperature:')

if st.button('Predict'):
    prediction = predict_weather(turbinity,temperature,ph)
    if prediction == 0:
        st.write('Bersih')
    else: 
        st.write('Keruh')
    data = {
        'ph': float(ph),
        'temperature':float(temperature),
        'kekeruhan':float(turbinity),
        'prediksi': int(prediction),
        'tanggal': current_date.date().isoformat(), 
        'waktu': waktu_sekrng
    }
    db.child('prediksi_cuaca').push(data)

    st.success('Prediksi berhasil didistribusikan ke Firebase.')