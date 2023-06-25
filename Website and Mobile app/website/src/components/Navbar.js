import Image from "next/image";
import logo from "../../public/logo_lab_putih.png";

export default function Navigation() {
  return (
    <nav className="grid grid-cols-2 gap-5 justify-center text-center navbar text-white font-mono min-h-10">
      <div className="justify-center items-center ml-10 col-start-1">
        <a href="/">
          <Image
            src={logo}
            alt="MBC Laboratory"
            style={{ width: "50%", height: "auto" }}
          />
        </a>
      </div>

      <div className="col-end-1 grid grid-cols-3 gap-3 mx-3">
        <span>
          <a href="/daily" style={{ textDecoration: "none", color: "inherit" }}>
            <p>Daily Report</p>
          </a>
        </span>
        <span>
          <a
            href="/weekly"
            style={{ textDecoration: "none", color: "inherit" }}
          >
            <p>Weekly Report</p>
          </a>
        </span>
        <span>
          <a
            href="/monthly"
            style={{ textDecoration: "none", color: "inherit" }}
          >
            <p>Monthly Report</p>
          </a>
        </span>
      </div>
    </nav>
  );
}
