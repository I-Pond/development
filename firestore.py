import streamlit as st
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
import joblib

# Mendapatkan kredensial Firestore dari file JSON
def get_firestore_credentials():
    # Ubah path ke file JSON kredensial Firestore Anda
    credentials_path = 'firestore.json'
    return credentials.Certificate(credentials_path)

# Inisialisasi koneksi ke Firestore
def initialize_firestore():
    if not firebase_admin._apps:
        cred = get_firestore_credentials()
        firebase_admin.initialize_app(cred)
    return firestore.client()

# Mendownload model dari Firestore
def download_model():
    db = initialize_firestore()
    model_ref = db.collection('mlpond').document('test')
    model_data = model_ref.get().to_dict()
    if model_data and 'model_bytes' in model_data:
        model_path = 'model.pkl'  # Nama lokal untuk menyimpan model
        with open(model_path, 'wb') as f:
            f.write(model_data['model_bytes'])
    else:
        st.write("Data model tidak ditemukan di Firestore.")

# Memuat model dari file lokal
def load_model():
    model_path = 'model.pkl'  # Path file lokal model
    model = joblib.load(model_path)
    return model

# Fungsi prediksi menggunakan model
def predict(model, input_data):
    # Lakukan prediksi menggunakan model
    prediction = model.predict(input_data)[0]
    result = "Bersih" if prediction == 0 else "Keruh"
    return result

# Simpan hasil prediksi ke Firestore
def save_prediction_result(result):
    db = initialize_firestore()
    predictions_ref = db.collection('predictions')
    predictions_ref.add({
        'result': result
    })

# Main program
def main():
    # Download model dari Firestore
    download_model()
    
    # Memuat model yang telah didownload
    model = load_model()

    # Tampilkan halaman Streamlit
    st.title("Water Quality Prediction")
    st.write("Masukkan data untuk melakukan prediksi.")

    # Ambil input dari pengguna
    ph = st.number_input("pH")
    temperature = st.number_input("Temperature")
    turbidity = st.number_input("Turbidity")

    # Jika ada input yang valid, lakukan prediksi
    if st.button("Predict"):
        input_data = [[ph, temperature, turbidity]]
        
        # Periksa apakah model telah dimuat dengan benar sebelum melakukan prediksi
        if model is not None:
            result = predict(model, input_data)
            st.write(f"Hasil Prediksi: {result}")
            
            # Simpan hasil prediksi ke Firestore
            save_prediction_result(result)
        else:
            st.write("Model tidak dapat dimuat. Silakan coba lagi.")

if __name__ == "__main__":
    main()
