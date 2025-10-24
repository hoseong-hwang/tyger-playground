import { useEffect } from "react";
import "./App.css";

function App() {
  useEffect(() => {
    // Flutter에서 호출할 전역 함수 등록
    window.onTest = function (data) {
      console.log("[WEB] Flutter에서 받은 onTest:", data);
      alert(`📩 Flutter → Web onTest 호출됨\n데이터: ${JSON.stringify(data)}`);
    };
  }, []);

  return (
    <div className="w-screen h-dvh flex flex-col items-center justify-center">
      <h1 className=" text-[40px] text-center font-bold my-[24px]">WEB</h1>
      <button
        onClick={() => {
          if (!window.flutter_inappwebview) return;

          window.flutter_inappwebview.callHandler("test", {
            action: "click",
            payload: { message: "웹에서 버튼 클릭!" },
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
