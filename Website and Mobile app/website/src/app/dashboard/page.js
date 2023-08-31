import style from "@/app/dashboard/dashboard.module.css";

export default function Dashboard() {
  return (
    <>
      <div className={`${style.container}`}>
        <h1 className={`${style.title}`}>Dashboard</h1>
        <iframe
          width="100%"
          height="80%"
          src="https://lookerstudio.google.com/embed/reporting/c35bb677-d509-4f04-b9be-dcc5f4334cf2/page/SQGbD"
          frameborder="0"
          style={{ border: 0 }}
          allowfullscreen
        ></iframe>
      </div>
    </>
  );
}
