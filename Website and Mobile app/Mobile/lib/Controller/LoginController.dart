import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myipond/Utils/Api.dart';
import 'package:myipond/Utils/Global.dart';
import 'package:myipond/Widget/hcaptchamobile.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../Model/User.dart';
import '../Utils/Firebase.dart';

class LoginController extends GetxController{

  var storage = GetStorage();
  var islogin = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController pass2Controller = TextEditingController();
  TextEditingController codeController = TextEditingController();
  String fcm  = "", idUser = '';
  User user = User(user : [UserElement(fcm: "", id: "", nama: "",
      akses: "", email: ""
  )]);
  int countWrong = 0;
  DeviceScreenType typeDevice = getDeviceType(Get.size);

  @override
  void onInit() {
    // TODO: implement onInit
    islogin = storage.read("login") ?? false;
    if (kDebugMode) {
      print("Login : " + islogin.toString());
    }
    initFCM();
    if(islogin == false){
      initToken();
    }else{
      getUser();
    }
    super.onInit();
  }

  getUser() async {
    idUser = storage.read("idUser");
    String urlPath = "User";
    var param = "idUser=$idUser";
    var response = await Api().get(urlPath, param);
    if(response != null){

      var data = json.decode(response.body);
      if(kDebugMode){
        print(response.body);
        print(data['user'][0]['akses']);
      }
      if(data['status'] == true){
        List<UserElement> listUser = [];
        listUser.add(UserElement(fcm: fcm, id: data['user'][0]['id'], nama: data['user'][0]['nama'],
            akses: data['user'][0]['akses'], email: data['user'][0]['email']
        ));
        user = User(
            user: listUser
        );
      }else{
        islogin = false;
        storage.write("login", false);
        storage.write("idUser", "");
      }
    }

    update();

  }

  loginProses(BuildContext context) async {
    // if()
    if(countWrong > 5 && !kIsWeb){
      Map? captchaDetails = {};
      if(kIsWeb){
        // captchaDetails = await HCaptchaWeb.show(context);
      }else{
        captchaDetails = await HCaptcha.show(context);
      }

      // validated
      if (captchaDetails == null) {
        Global().showInfo(message: "Captcha Anda salah", title: "Info");
        return;
        // now use captchaDetails['code']
      }
    }
    Global().showLoading("Memuat Data");

    String urlPath = "User/login";
    String type = "web";
    DeviceScreenType deviceType = getDeviceType(Get.size);
    if(DeviceScreenType.mobile == deviceType){
      type = "mobile";
    }
    var body = {
      "email"     : emailController.text,
      "password"  : passController.text,
      "fcm"       : fcm,
      "type"      : type
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
        List<UserElement> listUser = [];
        listUser.add(UserElement(fcm: fcm, id: data['user'][0]['id'], nama: data['user'][0]['nama'],
            akses: data['user'][0]['akses'], email: data['user'][0]['email']
        ));
        user = User(
            user: listUser
        );
        islogin = true;
        storage.write("login", true);
        storage.write("idUser", data['user'][0]['id']);
        idUser = data['user'][0]['id'];
        storage.write("email", data['user'][0]['email']);
        countWrong = 0;
        update();
      }else{
        countWrong ++;
      }

    }

  }

  logoutProses() async {
    Global().showLoading("Memuat Data");
    String urlPath = "User/logout";

    var body = {
      "email"     : storage.read("email")
    };
    // print(body);
    var response = await Api().post(urlPath, body);
    Global().dismissLoading();

    if(response != null){
      if (kDebugMode) {
        print(response.body);
      }
      var data = json.decode(response.body);
      Global().showInfo(message: data['info'], title: "Info");
      if(data['status'] == true){
        storage.erase();
        islogin = false;
        initToken();
        update();
      }

    }

  }

  Future<bool> requestOTPResetProses() async {
    Global().showLoading("Memuat Data");
    String urlPath = "User/requestOtp";

    var body = {
      "email"     : emailController.text,
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
        return true;
      }

    }
    return false;
  }

  Future<bool> verifyResetProses() async {
    Global().showLoading("Memuat Data");
    String urlPath = "User/verifyReset";

    var body = {
      "email"     : emailController.text,
      "password"  : passController.text,
      "code"      : codeController.text,
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
        return true;
      }

    }
    return false;

  }

  Future<void> initToken() async {
    if (GetPlatform.isIOS) {
      fcm = (await FirebaseMessaging.instance.getToken())!;
      // _token = (await FirebaseMessaging.instance.getAPNSToken())!;
    } else {
      fcm = (await FirebaseMessaging.instance.getToken())!;
    }
    debugPrint("token FCM : " + fcm);
  }

  initFCM() async {

    await FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage ?message) {
      if (kDebugMode) {
        print('Firebase Connect');
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {

      if (kDebugMode) {
        print("onMessage data: ${message.data}");
      }
      await FirebaseInit.showNotification(message);

    });

    // replacement for onResume: When the app is in the background and opened directly from the push notification.
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {

      if (kDebugMode) {
        print('onMessageOpenedApp data: ${message.data}');
      }
      await FirebaseInit.showNotification(message);

    });


  }

  Future<bool> onExit() async {
    return (await showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
        title: const Text('Apakah anda yakin?'),
        content: const Text('Apakah anda ingin keluar dari aplikasi?'),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Tidak'),
          ),
          ElevatedButton(
            onPressed: () => platformChannel(),
            child: const Text('Iya'),
          ),
        ],
      ),
    )) ?? false;
  }

  void platformChannel() {
    if(kIsWeb){
      SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
    }else if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else if (Platform.isIOS) {
      exit(0);
    }
  }

}