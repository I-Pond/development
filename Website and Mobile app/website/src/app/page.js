"use client";

import Image from "next/image";
import style from "@/app/homepage.module.css";
import { useRef } from "react";
import Link from "next/link";

export default function Dashboard() {
  const target = useRef(null);

  function handleClick() {
    target.current.scrollIntoView({ behavior: "smooth" });
  }

  return (
    <>
      <div className={`${style.title_container}`}>
        <div className={`${style.title_text}`}>
          <h1 className={`${style.title}`}>My-IPond</h1>
          <p className={`${style.description}`}>
            Welcome to My-IPond, your comprehensive destination for measuring
            Water Turbidity, pH, and Temperature, providing you with accurate
            information to maintain the cleanliness and health of your water.
          </p>
          <Link href="/" target="_blank" className={`${style.title_link}`}>
            Let's Try
          </Link>
        </div>
        <Image
          src="/data/Fisherman.png"
          alt="Fisherman picture"
          height={700}
          width={700}
          className={`${style.title_image}`}
        />
      </div>

      <div className={`${style.benefit_container}`}>
        <h1 className={`${style.benefit_title}`}>
          Manfaat My - Ipond Untuk Petambak Ikan
        </h1>
        <div className={`${style.benefit_desc_grid}`}>
          <div>
            <p>
              My I-Pond adalah sebuah inovasi yang dapat membantu petambak dalam
              budidaya ikan di sungai tambak. Tujuannya adalah untuk memantau
              kualitas air sungai tambak secara realtime, mengatasi perubahan
              cuaca dan musim yang mempengaruhi kualitas air, serta mengatasi
              kurangnya pemantauan berkala dan akurat pada air sungai tambak.
            </p>
            <Image
              src="/data/image 9.png"
              alt="tools"
              height={200}
              width={200}
            />
          </div>
          <div>
            <p>
              Dengan My I-Pond, para petambak memiliki alat yang kuat untuk
              meningkatkan produktivitas dan keberlanjutan budidaya ikan di
              sungai tambak. Dengan pemantauan yang lebih akurat dan respons
              yang lebih cepat terhadap perubahan kondisi, mereka dapat meraih
              hasil yang maksimal dalam usaha mereka.
            </p>
            <Image
              src="/data/image 10.png"
              alt="tools"
              height={200}
              width={200}
            />
          </div>
        </div>
      </div>
    </>
  );
}
