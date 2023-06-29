import Image from "next/image";

export default function about() {
  return (
    <main className="h-screen flex items-center flex-row">
      <div className="text-center mx-auto flex-1">
        <h1>My I-Pond</h1>
        <span>
          This is a project involving all of the division on MBC Laboratory.
          <br />
          This include the division of Cyber Security, BigData, Game Tech, and
          GIS.
        </span>
      </div>
      <div className="text-center mx-auto flex-1 object-center">
        <img className="scale-75" src="/logo.png" alt="logo" />
        <span>We are a laboratory.</span>
      </div>
    </main>
  );
}
