import streamlit as st
import pandas as pd
from google.cloud import bigquery
import joblib

# Mendapatkan kredensial GCP dari file JSON
def get_gcp_credentials():
    # Ubah path ke file JSON kredensial GCP Anda
    credentials_path = 'credential-keys.json'
    return bigquery.Client.from_service_account_json(credentials_path)

# Memuat model dari file lokal
def load_model():
    model_path = 'modelss5.pkl'  # Path file lokal model
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

        # Simpan hasil prediksi ke BigQuery
        client = get_gcp_credentials()
        dataset_id = 'your-dataset-id'
        table_id = 'your-table-id'
        table_ref = client.dataset(dataset_id).table(table_id)
        table = client.get_table(table_ref)

        # Membuat data frame dengan hasil prediksi
        data = [{'result': result}]
        df = pd.DataFrame(data)

        # Menambahkan data ke BigQuery
        errors = client.insert_rows(table, df.to_records(index=False))
        if errors:
            st.write("Gagal menyimpan hasil prediksi ke BigQuery.")
        else:
            st.write("Hasil prediksi berhasil disimpan ke BigQuery.")

if __name__ == "__main__":
    main()
