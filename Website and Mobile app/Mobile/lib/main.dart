import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myipond/Controller/DashboardController.dart';
import 'package:myipond/Controller/LoginController.dart';
import 'package:myipond/Controller/OtherController.dart';
import 'package:myipond/Controller/RegisterController.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'Utils/Firebase.dart';
import 'Utils/Routes.dart';
import 'View/WelcomeScreen.dart';

Future<void> main() async {
  await GetStorage.init();
  if(kIsWeb){
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyCnCR8XhWteUkvoV2viDljeGoAyGs7MD4g",
            authDomain: "my-i-pond.firebaseapp.com",
            databaseURL: "https://my-i-pond-default-rtdb.asia-southeast1.firebasedatabase.app",
            projectId: "my-i-pond",
            storageBucket: "my-i-pond.appspot.com",
            messagingSenderId: "841028351892",
            appId: "1:841028351892:web:b45ea2ca068cd41d60c181",
            measurementId: "G-3NN3HVWK69"
        )
    );
  }else{
    DeviceScreenType deviceType = getDeviceType(Get.size);
    if(DeviceScreenType.mobile == deviceType){
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }

    await Firebase.initializeApp();
  }
  FirebaseMessaging.onBackgroundMessage(FirebaseInit.firebaseMessagingBackgroundHandler);
  Get.put(OtherController());
  Get.put(LoginController());
  Get.put(RegisterController());
  Get.put(DashboardController());
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('launcher_icon');

  final IOSInitializationSettings initializationSettingsIOS =
  IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload,) async {

        if (kDebugMode) {
          print(title);
        }
        // didReceiveLocalNotificationSubject.add(
        //   ReceivedNotification(
        //     id: id,
        //     title: title,
        //     body: body,
        //     payload: payload,
        //   ),
        // );
      });
  const MacOSInitializationSettings initializationSettingsMacOS =
  MacOSInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
  );

  final LinuxInitializationSettings initializationSettingsLinux =
  LinuxInitializationSettings(
    defaultActionName: 'Open notification',
    defaultIcon: AssetsLinuxIcon('assets/images/logo.png'),
  );

  if(!kIsWeb){
    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
      macOS: initializationSettingsMacOS,
      // linux: initializationSettingsLinux,
    );
    await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onSelectNotification: (String? payload) async {
          if (payload != null) {
            debugPrint('notification payload: $payload');
          }
          // selectedNotificationPayload = payload;
          // selectNotificationSubject.add(payload);
        });
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.circularReveal,
      transitionDuration: const Duration(milliseconds: 800),
      builder: (context, child) {
        child = EasyLoading.init()(context, child);
        return MediaQuery(
          child: child,
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        );
      },
      title: 'MyIpond',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      home: WelcomeScreen(),
      getPages: Routes().listPage,
    );
  }
}