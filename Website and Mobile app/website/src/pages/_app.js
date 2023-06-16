import Head from "next/head";
import "@/styles/globals.css";
import "@/styles/progress.css";
import "bootstrap/dist/css/bootstrap.min.css";
import { SSRProvider } from "react-bootstrap";
import Navigation from "../components/Navbar";
import Footer from "../components/Footer";

export default function App({ Component, pageProps }) {
  return (
    <>
      <Head>
        <title>My I-Pond</title>
        <meta name="description" content="Monitor the quality of water." />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="icon" href="/logo_circle.ico" />
      </Head>
      <SSRProvider>
        <Navigation />
        <Component {...pageProps} />
        <Footer />
      </SSRProvider>
    </>
  );
}
