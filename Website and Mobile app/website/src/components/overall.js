"use client";

import style from "@/styles/progress.module.css";
import { dataRef } from "@/utils/firebase";
import { limitToLast, query, onValue } from "firebase/database";
import { useEffect, useState } from "react";

export default function Overall() {
  const [data, setData] = useState({
    ph: null,
    temperature: null,
    turbinity: null,
    tanggal: null,
  });

  const [detail, setDetail] = useState({});

  const handleDaily = async () => {
    try {
      const ref = dataRef();
      const quer = query(ref, limitToLast(1));
      await onValue(quer, (snap) => {
        snap.forEach((child) => {
          const children = child.val();
          setData({
            ...data,
            ph: children.ph,
            temperature: children.Temperature,
            turbinity: children.Turbinity,
            tanggal: children.Tanggal,
          });
        });
      });
    } catch (e) {
      console.log(e);
    }
  };

  useEffect(() => {
    handleDaily();
  }, []);

  let OverallData = 50;
  const progress = (OverallData / 134) * 100;

  console.log(data);

  if (data.ph != null && data.temperature != null && data.turbinity != null) {
    const result = fetch(
      `https://backend-nine-rho.vercel.app/predict/${data.ph}/${data.temperature}/${data.turbinity}`
    )
      .then((res) => res.json())
      .then((json) => setDetail(json))
      .catch((e) => console.log(e));
  }

  // console.log(detail);

  return (
    <div className={style.container} style={{}}>
      <div className={style.outer} style={{ "--progress": `${progress}%` }}>
        <div className={style.value}>{OverallData} ml/L</div>
      </div>
    </div>
  );
}
