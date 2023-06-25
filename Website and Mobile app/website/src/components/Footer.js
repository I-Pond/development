import Image from "next/image";
import logo from "../../public/logo_lab_putih.png";

export default function Footer() {
  return (
    <footer
      className="h-64 grid grid-cols-2 items-center"
      style={{ background: "#011422" }}
    >
      <div className="col-start-1 m-auto">
        <a href="https://www.instagram.com/mbclab/" target="_blank">
          <Image src={logo} alt="MBC Laboratory" />
        </a>
      </div>
      <div className="col-span-1 text-white grid grid-cols-3">
        <div className="col-span-1">
          <h1 style={{ cursor: "default" }}>About</h1>
          <a href="/about" style={{ textDecoration: "none", color: "inherit" }}>
            <p>About us</p>
          </a>
          <a
            href="/features"
            style={{ textDecoration: "none", color: "inherit" }}
          >
            <p>Features</p>
          </a>
          <a href="/news" style={{ textDecoration: "none", color: "inherit" }}>
            <p>News & Blogs</p>
          </a>
        </div>
        <div className="col-span-1">
          <h1 style={{ cursor: "default" }}>Contact</h1>
          <a
            href="https://www.instagram.com/mbclab/"
            target="_blank"
            style={{ textDecoration: "none", color: "inherit" }}
          >
            <p>Instagram</p>
          </a>
          <p>Whatsapp</p>
          <p>Linkedin</p>
        </div>
        <div className="col-span-1">
          <h1 style={{ cursor: "default" }}>Support</h1>
          <p>FAQs</p>
          <p>Support Center</p>
        </div>
      </div>
    </footer>
  );
}
