import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myipond/Model/Rule.dart';
import 'package:myipond/Utils/Global.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Utils/Api.dart';

class OtherController extends GetxController{
  String title = "", isi = "";
  Rule? rule;

  void directUrl(String url) async {
    try{
      var data = await launchUrl(Uri.parse(url));
      if (kDebugMode) {
        print(data);
      }
    }catch(e){
      if (kDebugMode) {
        print(e);
      }
      Global().showInfo(message: e.toString(), title: "Info");
    }
  }

  int cekStatus(double max, double min, double value){
    int value = 0;

    if(value < min){
      value = 1;
    }

    if(value > max){
      value = 2;
    }

    return value;
  }

  Color getColorStatus(int cekStatus){
    if(cekStatus == 1){
      return Colors.redAccent;
    }
    if(cekStatus == 2){
      return Colors.black;
    }

    return Colors.green;

  }

  getRule() async {
    String url        = "other/rule";
    String param      = "";
    var response = await Api().get(url, param);
    if(response != null){
      rule = ruleFromJson(response.body);
    }
  }

  launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

}