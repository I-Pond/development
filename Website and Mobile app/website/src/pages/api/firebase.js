import { initializeApp } from "firebase/app";
import { getDatabase, ref } from "firebase/database";

const firebaseConfig = {
  apiKey: process.env.NEXT_PUBLIC_API,
  authDomain: process.env.NEXT_PUBLIC_AUTH,
  databaseURL: process.env.NEXT_PUBLIC_DATABASE,
  projectId: process.env.NEXT_PUBLIC_ID,
  storageBucket: process.env.NEXT_PUBLIC_BUCKET,
  messagingSenderId: process.env.NEXT_PUBLIC_SENDERID,
  appId: process.env.NEXT_PUBLIC_APP,
  measurementId: process.env.NEXT_PUBLIC_MEASUREMENT,
};

const app = initializeApp(firebaseConfig);
const initDatabase = getDatabase(app);
const database = ref(initDatabase, "/Prototype/Ipone");

export default app;
export { database };
