import style from "@/styles/progress.module.css";

export default function temperature() {
  let tempData = 20;
  return (
    <div
      className=""
      style={{
        borderRadius: "5px",
        background:
          "linear-gradient(180deg,rgba(1, 20, 34, 1) 15%,rgba(25,64,83,255) 50%)",
      }}
    >
      <div className={style.container} style={{ marginTop: "30px" }}>
        <div className={style.outer} style={{ "--progress": `${tempData}%` }}>
          <div className={style.value}>{tempData}∘</div>
        </div>
        <h1 className="pt-0 font-serif text-xl mb-10">Temperature</h1>
      </div>
    </div>
  );
}
