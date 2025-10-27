import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewPage extends StatefulWidget {
  const WebviewPage({super.key});

  @override
  State<WebviewPage> createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  // InAppWebViewController? _controller;
  WebViewController? _webViewController;

  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'AppChannel',
        onMessageReceived: (msg) {
          final Map<String, dynamic> data =
              jsonDecode(msg.message) as Map<String, dynamic>;
          _show(data["payload"]["title"], data["payload"]["message"]);
        },
      )
      ..loadRequest(Uri.parse('http://localhost:5173/'));
  }

  // void _handler(InAppWebViewController controller) {
  //   controller.addJavaScriptHandler(
  //     handlerName: "onTest",
  //     callback: (List<dynamic> args) {
  //       final Map<dynamic, dynamic> data = args.isNotEmpty ? args.first : {};
  //       final Map<dynamic, dynamic> payload = data["payload"];
  //       final String title = payload["title"];
  //       final String subTitle = payload["message"];
  //       showDialog(
  //         context: context,
  //         builder: (_) => Dialog(
  //           child: Container(
  //             padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 Text(
  //                   title,
  //                   style: const TextStyle(
  //                     fontWeight: FontWeight.bold,
  //                     fontSize: 16,
  //                   ),
  //                 ),
  //                 const SizedBox(height: 12),
  //                 Text(
  //                   subTitle,
  //                   style: const TextStyle(
  //                     fontWeight: FontWeight.w400,
  //                     fontSize: 14,
  //                     color: Color.fromRGBO(105, 105, 105, 1),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       );
  //       return {"result": true};
  //     },
  //   );
  // }

  void _show(String title, String message) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                message,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Color.fromRGBO(105, 105, 105, 1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF262626),
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          "Webview Communication",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF262626),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Expanded(
            //   child: SizedBox(
            //     width: MediaQuery.of(context).size.width,
            //     child: InAppWebView(
            //       initialUrlRequest:
            //           URLRequest(url: WebUri("http://localhost:5173/")),
            //       onWebViewCreated: (controller) {
            //         _controller = controller;
            //         _handler(controller);
            //       },
            //     ),
            //   ),
            // ),
            Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: _webViewController != null
                    ? WebViewWidget(
                        controller: _webViewController!,
                      )
                    : const SizedBox.shrink(),
              ),
            ),
            Expanded(
              child: Container(
                color: const Color.fromRGBO(215, 215, 215, 1),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Text(
                        "APP",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        final payload = {
                          "title": "APP → WEB",
                          "message": "이 메시지는 앱에서 요청했습니다.",
                        };

                        final script = """
    (function() {
      try {
        if (typeof window.onAppEvent === 'function') {
          window.onAppEvent("flutter_click", ${jsonEncode(payload)});
        } else {
          console.warn("window.onAppEvent not ready");
        }
      } catch (e) {
        console.error("onAppEvent error:", e);
      }
    })();
  """;
                        print(script);
                        await _webViewController?.runJavaScript(script);

                        // final String script = "window.onTest(${jsonEncode({
                        //       "title": "APP → WEB",
                        //       "message": "이 메시지는 앱에서 요청했습니다.",
                        //     })});";
                        // _controller?.evaluateJavascript(source: script);
                      },
                      child: Container(
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Center(
                          child: Text(
                            "ACTION",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
