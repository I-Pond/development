import PH from "@/components/ph";
import Temp from "@/components/temperature";
import Clarity from "@/components/clarity";

export default async function page() {
  const data = 200;
  return (
    <main>
      <section
        className="grid grid-cols-2 m-10 p-10 h-128 gap-5 items-center"
        style={{ border: "2px double black", borderRadius: "10px" }}
      >
        {/* PH Section */}
        <div>
          <div>
            <PH state="weekly" total_data={data} />
          </div>
        </div>
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
            hidrogen". Ini adalah ukuran yang digunakan untuk menentukan
            keasaman atau kebasaan suatu larutan. Skala pH berkisar dari 0
            hingga 14, dimana 7 dianggap netral. Nilai pH dibawah 7 menunjukan
            sifat keasaman, sedangkan nilai pH diatas 7 menunjukan sifat
            kebasaan. Semakin rendah nilai pH, semakin asam larutan tersebut,
            dan semakin tinggi nilai pH, semakin basa larutan tersebut.
          </p>
        </div>
      </section>

      <section
        className="grid grid-cols-2 m-10 p-10 h-128 gap-5 items-center"
        style={{ border: "2px double black", borderRadius: "10px" }}
      >
        <div>
          <div>
            <Temp state="weekly" total_data={data} />
          </div>
        </div>
        <div className="mr-10">
          <h1
            className="text-6xl mb-5 font-serif"
            style={{ color: "#0e2954", paddingBottom: "10px" }}
          >
            Temperature
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
            Temperature air adalah ukuran suhu air dari udara di sekitar kita.
            Suhu udara dapat bervariasi tergantung pada faktor-faktor seperti
            cuaca, musim, lokasi geografis, dan waktu. Suhu udara diukur dalam
            derajat Celcius (℃).
          </p>
        </div>
      </section>

      <section
        className="grid grid-cols-2 m-10 p-10 gap-5 h-128 items-center"
        style={{ border: "2px double black", borderRadius: "10px" }}
      >
        <div>
          <div>
            <Clarity state="weekly" total_data={data} />
          </div>
        </div>
        <div className="mr-10">
          <h1
            className="text-6xl mb-5 font-serif"
            style={{ color: "#0e2954", paddingBottom: "10px" }}
          >
            Clarity
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
            Kekeruhan pada tambak ikan dapat disebabkan oleh beberapa faktor.
            Pertama, sedimen dan partikel tersuspensi seperti lumpur, debu, atau
            serpihan makanan ikan dapat menjadi penyebab kekeruhan air. Ketika
            partikel-partikel ini tercampur dan mengendap didalam air, mereka
            mengurangi kejernihan air dengan membuatnya keruh.
          </p>
        </div>
      </section>
    </main>
  );
}
