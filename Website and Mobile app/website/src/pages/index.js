import Progress from "@/components/card/progress";

export default function Dashboard() {
  return (
    <>
      <main>
        <div
          className="title text-center font-mono h-screen"
          style={{ borderTop: "1px solid black" }}
        >
          <div className="title-text">
            <h1>Welcome</h1>
            <span>Automation water quality control.</span>
          </div>
        </div>
      </main>

      <div className="text-center m-10">
        <h1 className="font-serif">Status</h1>
        <div className="min-h-fit m-10 grid grid-cols-3 gap-3">
          <Progress name="pH Status" percent="50" />
          <Progress name="Turbidity Status" percent="50" />
          <Progress name="Temperature Status" percent="50" />
        </div>
      </div>
    </>
  );
}
