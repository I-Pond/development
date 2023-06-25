import Image from "next/image";
import Progress from "@/components/card/progress";

export default function Dashboard() {
  return (
    <>
      <main className="grid grid-cols-2 gap-2 justify-center items-center h-screen">
        <div className="col-span-1 pl-10">
          <h1 style={{ color: "#0e2954" }}>My-Ipond</h1>
          <p className="text-xl">
            Welcome to iPond, your comprehensive destination for measuring water
            turbidity, pH, and temperature, providing you with accurate
            information to maintain the cleanliness and health of your water.
          </p>
          <button className="try-me w-32 h-10">Let's Try</button>
        </div>
        <div className="img-card grid grid-cols-2 gap-5 m-3">
          <Image
            src="https://images.unsplash.com/photo-1659835347242-97835d671db7?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1935&q=80"
            width={250}
            height={250}
            sizes="(max-width: 250px)"
          />
          <Image
            src="/screaming_cat.png"
            width={250}
            height={250}
            sizes="(max-width: 250px)"
          />
          <Image src="/screaming_cat.png" width={250} height={250} />
          <Image src="/screaming_cat.png" width={250} height={250} />
        </div>
      </main>

      <div className="welcome h-screen">
        <div className="w-1/2 m-10">
          <h1>
            Welcome to iPond, where we make water clarity testing smarter!
          </h1>
        </div>
      </div>
    </>
  );
}
