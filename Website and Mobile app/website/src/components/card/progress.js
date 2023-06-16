export default function Progress({ percent, name }) {
  if (percent < 1) {
    percent = 1;
  }
  return (
    <>
      <div className="container">
        <div className="card" style={{ "--progress-percent": percent }}>
          <div className="box">
            {/* <h2 className="text">{name}</h2> */}
            <div className="percent">
              <svg>
                <circle cx="70" cy="70" r="70"></circle>
                <circle cx="70" cy="70" r="70"></circle>
              </svg>
              <div className="num">
                <h2>
                  {percent}
                  <span>%</span>
                </h2>
              </div>
            </div>
            <h2 className="text">{name}</h2>
          </div>
        </div>
      </div>
    </>
  );
}
