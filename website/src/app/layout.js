import "@/styles/globals.css";
import Image from "next/image";
import logo from "../../public/logo_lab_putih.png";

export const metadata = {
  title: "My I-Pond",
  description: "Monitor the quality of water.",
  icons: {
    icon: "/images/favicon.ico",
    shortcut: "/images/logo_circle.png",
  },
};

export default function RootLayout({ children }) {
  return (
    <>
      <html lang="en">
        <body>
          <nav className="grid grid-cols-2 gap-5 justify-center text-center navbar text-white font-mono min-h-10">
            <div className="items-center m-3 ml-10 col-start-1">
              <a href="/">
                <Image
                  src={logo}
                  alt="MBC Laboratory"
                  style={{ width: "30%", height: "auto" }}
                />
              </a>
            </div>

            <div className="grid grid-cols-3 gap-3 mx-3 items-center text-lg">
              <span>
                <a
                  href={`/daily`}
                  style={{ textDecoration: "none", color: "inherit" }}
                >
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

          {children}

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
                <a
                  href="/about"
                  style={{ textDecoration: "none", color: "inherit" }}
                >
                  <p>About us</p>
                </a>
                <a
                  href="/features"
                  style={{ textDecoration: "none", color: "inherit" }}
                >
                  <p>Features</p>
                </a>
                <a
                  href="/news"
                  style={{ textDecoration: "none", color: "inherit" }}
                >
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
        </body>
      </html>
    </>
  );
}
