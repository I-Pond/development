"use client";

import style from "@/styles/progress.module.css";
import { dataRef } from "@/utils/firebase";
import { limitToLast, onValue, query } from "firebase/database";
import { useEffect, useState } from "react";

export default function Clarity({ state, total_data = 1 }) {
  const [data, setData] = useState(0);

  const handleDaily = async () => {
    const ref = dataRef();
    const quer = query(ref, limitToLast(1));
    await onValue(quer, (snap) => {
      const obj = Object.values(snap.val());
      setData(obj[0].Turbinity);
    });
  };

  const handleWeekly = async () => {
    const ref = dataRef();
    const quer = query(ref, limitToLast(total_data));
    await onValue(quer, (snap) => {
      let total_ph = 0.0;
      let total_temp = 0.0;
      let total_tur = 0.0;
      const obj = Object.values(snap.val());
      obj.forEach((data) => {
        const ph = parseFloat(data.ph);
        const turbidity = parseFloat(data.Turbinity);
        const temp = parseFloat(data.Temperature);
        total_ph = ph + total_ph;
        total_temp = temp + total_temp;
        total_tur = turbidity + total_tur;
      });
      setData((total_tur / total_data).toFixed(2));
    });
  };

  useEffect(() => {
    switch (state) {
      case "daily":
        handleDaily();
        break;

      case "weekly":
        handleWeekly();
        break;

      case "monthly":
        break;

      default:
        break;
    }
  }, []);

  const progress = (data / 6) * 100;
  return (
    <div className={style.container} style={{}}>
      <div className={style.outer} style={{ "--progress": `${progress}%` }}>
        <div className={style.value}>{data}</div>
      </div>
    </div>
  );
}
