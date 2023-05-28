import Image from "next/image";

export default function Footer() {
  return (
    <div className="footer h-32 text-center grid grid-cols-3 gap-3 bg-gray-700">
      <div className="flex justify-center items-center">
        <a href="https://www.instagram.com/mbclab/" target="_blank">
          <img src="./logo.png" alt="MBC Laboratory" className="max-h-20" />
        </a>
      </div>
      <div className="col-span-2 font-mono text-white m-auto block">
        <a href="/about" style={{ textDecoration: "none", color: "inherit" }}>
          <h3>About</h3>
        </a>
        <a href="/docs" style={{ textDecoration: "none", color: "inherit" }}>
          <h3>Documentasion</h3>
        </a>
      </div>
    </div>
  );
}
