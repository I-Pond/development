"use client";

import Image from "next/image";
import Ph from "@/components/ph";
import Temperature from "@/components/temperature";
import Clarity from "@/components/clarity";
import Overall from "@/components/overall";
import { useRef } from "react";

export default function Dashboard() {
  const target = useRef(null);

  function handleClick() {
    target.current.scrollIntoView({ behavior: "smooth" });
  }

  return (
    <>
      <main className="grid grid-cols-2 gap-2 justify-center items-center h-screen">
        <div className="col-span-1 pl-10">
          <h1
            className="pb-3 text-4xl font-semibold"
            style={{ color: "#0e2954" }}
          >
            My-Ipond
          </h1>
          <p className="text-lg pb-3">
            Welcome to iPond, your comprehensive destination for measuring water
            turbidity, pH, and temperature, providing you with accurate
            information to maintain the cleanliness and health of your water.
          </p>
          <button className="try-me w-32 h-10" onClick={handleClick}>
            Let's Try
          </button>
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

      <div className="welcome h-screen" ref={target}>
        <div className="w-1/2 m-10">
          <h1
            className="pb-3 text-4xl font-semibold pt-5 mr-16"
            style={{ color: "#0e2954" }}
          >
            Welcome to iPond, where we make water clarity testing smarter!
          </h1>
        </div>
        <div className="grid grid-cols-4 gap-10 mt-5 text-center font-semibold text-white m-10 items-center justify-center">
          <div>
            <Ph />
          </div>
          <div>
            <Temperature />
          </div>
          <div>
            <Clarity />
          </div>
          <div>
            <Overall />
          </div>
        </div>
      </div>
    </>
  );
}
