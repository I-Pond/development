import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class Global{
  String appName = "My-iPond";

  showInfo({required String message, required String title}){
    Get.snackbar(title, message);
  }

  showLoading(String text) {
    EasyLoading.instance
    // ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Colors.white
      ..backgroundColor = const Color.fromRGBO(229, 83, 0, 1)
      ..indicatorColor = Colors.white
      ..textColor = Colors.white
    // ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = false
      ..maskType = EasyLoadingMaskType.black
      ..dismissOnTap = false;
    EasyLoading.show(status: text);
  }

  dismissLoading() {
    EasyLoading.dismiss();
  }
}