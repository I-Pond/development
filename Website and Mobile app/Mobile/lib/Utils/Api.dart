import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'Global.dart';

class Api{

  static String url = "https://beipond.demosky.my.id";
  String urlApi = url + "/index.php/api/";


  Future post(String url, Object body) async {
    var urlS = urlApi + url;
    if (kDebugMode) {
      // print(header);
      print("ambil data Post : $urlS");
      print(body);
    }
    try{
      final http.Response response = await http.post(
        Uri.parse(urlS),
        body: body,
        // headers: header
      );
      return response;
    }catch(e){
      if (kDebugMode) {
        print(e);
      }
      Global().showInfo(message: e.toString(), title: "Info");
      return null;

    }

  }

  Future get(String url, String param) async {
    var urlS = "";
    if(param == ""){
      urlS = urlApi + url;
    }else{
      urlS = urlApi + url + "?" + param;
    }
    if (kDebugMode) {
      print("ambil data Get : $urlS");
    }
    try{
      final http.Response response = await http.get(
          Uri.parse(urlS),
        // headers: header
      );
      return response;
    }catch(e){
      if (kDebugMode) {
        print(e);
      }
      Global().showInfo(message: e.toString(), title: "Info");
      return null;
    }

  }

  Future postMultipart(http.MultipartRequest request) async {
    try{

      //-------Send request
      var resp = await request.send();

      return resp;
    }catch(e){
      if (kDebugMode) {
        print(e);
      }
      Global().showInfo(message: e.toString(), title: "Info");
      return null;

    }

  }

}