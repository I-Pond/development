import style from "@/app/predictor/predict.module.css";

export default function Predictor() {
  return (
    <>
      <div className={`${style.container}`}>
        <h1 className={`${style.title}`}>Water Prediction</h1>
        <iframe
          src="https://deployml.streamlit.app/?embed=true"
          height="85%"
          style={{ width: "100%", border: "none" }}
        ></iframe>
      </div>
    </>
  );
}
