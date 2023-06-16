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
        <div className="m-10 grid grid-rows-3 gap-3">
          <div className="grid grid-cols-2 gap-2 items-center justify-center">
            <Progress name="pH" percent="15" />
            <div className="text-center">
              <h2>Daily Report</h2>
              <table className="daily-report">
                <tr>
                  <th>#</th>
                  <th>Date</th>
                  <th>Report</th>
                </tr>
                <tr>
                  <td>1</td>
                  <td>3 Mei 2023</td>
                  <td>no data</td>
                </tr>
              </table>
            </div>
          </div>
          {/* 
          <div className="grid grid-cols-2 gap-2">
            <Progress name="Turbidity" percent="0" />
            <h2>Daily Report</h2>
          </div>

          <div className="grid grid-cols-2 gap-2">
            <Progress name="Temperature" percent="0" />
            <h2>Daily Report</h2>
          </div> */}
        </div>
      </div>
    </>
  );
}
