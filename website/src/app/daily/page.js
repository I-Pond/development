import { dataRef } from "@/utils/firebase";
import {
  orderByChild,
  limitToLast,
  onValue,
  get,
  child,
} from "firebase/database";

export default async function page() {
  // const date = new Date();
  // const ref = dataRef;
  // const query = limitToLast(5);
  // console.log("reading database");
  // const fetchedData = await get(child(query));
  // console.log(fetchedData ? fetchedData.val() : "for fuck sake");

  // const res = await fetch(
  //   `https://backend-nine-rho.vercel.app/predict/6.00/26.00/0`
  // );
  // const data = await res.json();
  // console.log(date);

  return (
    <main className="grid grid-cols-2 pt-10 h-screen items-center">
      <div className="">Some new component i guess</div>
      <div className="mr-10">
        <h1
          className="text-6xl mb-5 font-serif"
          style={{ color: "#0e2954", paddingBottom: "10px" }}
        >
          pH
        </h1>
        <div
          className="grid grid-cols-3 font-mono font-bold"
          style={{ border: "2px solid #0e2954", borderRadius: "10px" }}
        >
          <button>Daily</button>
          <button>Weekly</button>
          <button>Monthly</button>
        </div>
        <p className="text-xl">
          "Penghujung" atau "pH" adalah sebuah singkatan untuk "potensi
          hidrogen". Ini adalah ukuran yang digunakan untuk menentukan keasaman
          atau kebasaan suatu larutan. Skala pH berkisar dari 0 hingga 14,
          dimana 7 dianggap netral. Nilai pH dibawah 7 menunjukan sifat
          keasaman, sedangkan nilai pH diatas 7 menunjukan sifat kebasaan.
          Semakin rendah nilai pH, semakin asam larutan tersebut, dan semakin
          tinggi nilai pH, semakin basa larutan tersebut.
        </p>
      </div>
    </main>
  );
}
