import { useEffect } from "react";
import "./App.css";

function App() {
  useEffect(() => {
    window.onTest = function (data) {
      alert(`${data.title}\n\n${data.message}`);
    };
  }, []);

  return (
    <div className="w-screen h-dvh flex flex-col items-center justify-center">
      <h1 className=" text-[40px] text-center font-bold my-[24px]">WEB</h1>
      <button
        onClick={() => {
          if (!window.flutter_inappwebview) return;
          window.flutter_inappwebview.callHandler("onTest", {
            action: "click",
            payload: {
              title: "WEB → APP",
              message: "이 메시지는 웹에서 요청했습니다.",
            },
          });
        }}
        className="bg-cyan-400 rounded-sm w-[150px] h-[50px] text-black font-bold text-[16px]"
      >
        ACTION
      </button>
    </div>
  );
}

export default App;
