import { initializeApp } from "firebase/app";
import {
  getDatabase,
  ref,
  query,
  orderByChild,
  limitToLast,
  onValue,
} from "firebase/database";

function dataRef() {
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
  return ref(initDatabase, "/Prototype/Ipone");
}

export { dataRef };
