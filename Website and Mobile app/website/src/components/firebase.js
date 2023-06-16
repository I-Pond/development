// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyBlgP8PYLo1yU83Pqxa0rxHIpRGCNA2pfU",
  authDomain: "testing-8c436.firebaseapp.com",
  projectId: "testing-8c436",
  storageBucket: "testing-8c436.appspot.com",
  messagingSenderId: "1023640828472",
  appId: "1:1023640828472:web:52f87834f6f24ae92fc4cd",
  measurementId: "G-JLDLCFMMC6",
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);

export default app;
export const initFirebase = () => {
  return app;
};
