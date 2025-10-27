import { useEffect } from "react";
import "./App.css";

const App = () => {
  return (
    <div className="w-screen h-dvh flex flex-col items-center ">
      <h1 className="font-bold text-[24px] pt-[24px]">{"Sample WEB"}</h1>
      <div className="flex flex-1 flex-col items-center justify-center gap-[8px]"></div>
    </div>
  );
};

// function App() {
//   useEffect(() => {
//     window.onTest = function (data) {
//       alert(`${data.title}\n\n${data.message}`);
//     };
//   }, []);

//   useEffect(() => {
//     window.onAppEvent = (event, data) => {
//       console.log("[WEB] from app:", event, data);

//       // ✅ DOM에 직접 출력 (alert 대신)
//       const el = document.createElement("div");
//       el.textContent = `${data.title} / ${data.message}`;
//       el.style.cssText =
//         "position:fixed;left:16px;bottom:16px;padding:12px 16px;background:#111;color:#fff;border-radius:8px;z-index:99999;";
//       document.body.appendChild(el);
//       setTimeout(() => el.remove(), 2500);
//     };
//   }, []);

//   return (
//     <div className="w-screen h-dvh flex flex-col items-center justify-center">
//       <h1 className=" text-[40px] text-center font-bold my-[24px]">WEB</h1>
//       <button
//         onClick={() => {
//           // if (!window.flutter_inappwebview) return;
//           // window.flutter_inappwebview.callHandler("onTest", {
//           //   action: "click",
//           //   payload: {
//           //     title: "WEB → APP",
//           //     message: "이 메시지는 웹에서 요청했습니다.",
//           //   },
//           // });
//           // if (!window.onTest) return;

//           if (!window.AppChannel || !window.AppChannel.postMessage) {
//             console.log("[WEB] AppChannel not ready");
//             return;
//           }
//           const payload = {
//             action: "click",
//             payload: {
//               title: "WEB → APP",
//               message: "이 메시지는 웹에서 요청했습니다.",
//             },
//           };
//           window.AppChannel.postMessage(JSON.stringify(payload));
//           console.log("[WEB] sent via AppChannel:", payload);
//         }}
//         className="bg-cyan-400 rounded-sm w-[150px] h-[50px] text-black font-bold text-[16px]"
//       >
//         ACTION
//       </button>
//     </div>
//   );
// }

export default App;
