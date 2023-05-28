library hcaptcha;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HCaptcha {

  static Future<Map?> show(BuildContext context) async {
    // print(_initialUrl);
    return Navigator.push<Map>(
      context,
      MaterialPageRoute(
        builder: (context) => HCaptchaScreen(),
      ),
    );
  }
}

class HCaptchaScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // print(_initialUrl);
    return Center(
        child: WebView(
          initialUrl: "https://captcha.ngpro.id",
          javascriptMode: JavascriptMode.unrestricted,
          javascriptChannels: <JavascriptChannel>{
            JavascriptChannel(
                name: 'Captcha',
                onMessageReceived: (JavascriptMessage message) {
                  // https://docs.hcaptcha.com/#server
                  Navigator.of(context).pop({
                    'code': message.message,
                  });
                })
          },
          onWebViewCreated: (WebViewController w) {
            // webViewController = w;
          },
        ));
  }
}
