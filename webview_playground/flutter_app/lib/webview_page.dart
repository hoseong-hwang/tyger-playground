import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebviewPage extends StatefulWidget {
  const WebviewPage({super.key});

  @override
  State<WebviewPage> createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  InAppWebViewController? _controller;

  void _handler(BuildContext context) {
    _controller?.addJavaScriptHandler(
      handlerName: "test",
      callback: (List<dynamic> args) {
        final Map<dynamic, dynamic> data = args.isNotEmpty ? args.first : {};

        final String action = data["action"];
        if (action == "click") {
          final dynamic payload = data["payload"];
          print("[APP] 버튼 클릭 이벤트 수신: $payload");
          showDialog(
            context: context,
            // barrierDismissible: false,
            builder: (_) => Dialog(
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Text('asdf adsf'),
              ),
            ),
          );
        }
        return {"received": true, "action": action};
      },
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
            Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: InAppWebView(
                  initialUrlRequest:
                      URLRequest(url: WebUri("http://localhost:5173/")),
                  onWebViewCreated: (controller) {
                    _controller = controller;
                    _controller?.addJavaScriptHandler(
                      handlerName: "test",
                      callback: (List<dynamic> args) {
                        final Map<dynamic, dynamic> data =
                            args.isNotEmpty ? args.first : {};

                        final String action = data["action"];
                        if (action == "click") {
                          final dynamic payload = data["payload"];
                          print("[APP] 버튼 클릭 이벤트 수신: $payload");
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) => Dialog(
                              child: GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: Text('asdf adsf'),
                              ),
                            ),
                          );
                        }
                        return {"received": true, "action": action};
                      },
                    );
                    // _handler(context);
                  },
                ),
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
                      onTap: () {
                        final script = "window.onTest(${jsonEncode({
                              'from': 'Flutter',
                              'message': 'Hello Web!'
                            })});";
                        _controller?.evaluateJavascript(source: script);
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
