import Image from "next/image";

export default function Navigation() {
  return (
    <div className="grid grid-cols-4 max-h-fit m-2 justify-center items-center text-center">
      <div className="flex justify-center items-center">
        <a href="/">
          <Image
            src="/logo.png"
            alt="MBC Laboratory"
            width={250}
            height={250}
            sizes="(max-width: 250px)"
          />
        </a>
      </div>
      <div className="col-span-2 font-mono min-h-fit">
        <h1>My I-Pond</h1>
      </div>
      <div className="flex justify-center items-center">
        <a href="https://www.instagram.com/mbclab/" target="_blank">
          {/* <Image src="/logo_circle.ico" alt="button" width={100} height={100} /> */}
          <img
            src="./logo_circle.ico"
            alt="burger"
            className="max-h-12"
            style={{ float: "right" }}
          />
        </a>
      </div>
    </div>
  );
}
