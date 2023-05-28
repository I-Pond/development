import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:myipond/Utils/Routes.dart';

import '../Utils/Api.dart';
import '../Utils/Global.dart';

class RegisterController extends GetxController{
  var namaController = TextEditingController();
  var emailController = TextEditingController();
  var passController = TextEditingController();

  registerProses() async {
    Global().showLoading("Memuat Data");
    String urlPath = "User/register";
    var body = {
      "nama"      : namaController.text,
      "email"     : emailController.text,
      "password"  : passController.text,
      "akses"     : "member"
    };
    var response = await Api().post(urlPath, body);
    Global().dismissLoading();

    if(response != null){
      if (kDebugMode) {
        print(response.body);
      }
      var data = json.decode(response.body);
      Global().showInfo(message: data['info'], title: "Info");
      if(data['status'] == true){
        Get.toNamed(Routes().home);
      }

    }

  }
}