import streamlit as st
from google.cloud import storage
import joblib

# Mendapatkan kredensial GCP dari file JSON
def get_gcp_credentials():
    # Ubah path ke file JSON kredensial GCP Anda
    credentials_path = 'credential-keys.json'
    return storage.Client.from_service_account_json(credentials_path)

# Mendownload model dari GCP Storage
def download_model():
    client = get_gcp_credentials()
    bucket_name = 'mlpond'
    model_filename = 'modelss5.pkl'
    local_model_path = 'model.pkl'  # Nama lokal untuk menyimpan model

    bucket = client.get_bucket(bucket_name)
    blob = bucket.blob(model_filename)
    blob.download_to_filename(local_model_path)

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

# Main program
def main():
    # Download model dari GCP Storage
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
        result = predict(model, input_data)
        st.write(f"Hasil Prediksi: {result}")

if __name__ == "__main__":
    main()
