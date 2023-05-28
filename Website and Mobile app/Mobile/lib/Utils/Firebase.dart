import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:myipond/Controller/DashboardController.dart';
import 'package:myipond/Controller/LoginController.dart';

import 'Global.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

class FirebaseInit{

  static Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    // var chatController = Get.put(ChatController());

    debugPrint("Data" + message.data.toString());
    await showNotification(message);

  }


  static showNotification(RemoteMessage message) async {
    var dashboardController = Get.put(DashboardController());
    var title = '';
    var body = '';
    String payload = "";
    title = message.data['title'];
    body = message.data['body'];

    if(message.data['type'] == "history"){
      dashboardController.getHistory();
    }

    if(kIsWeb) {
      Global().showInfo(message: body, title: title);
      return;
    }
    if(GetPlatform.isWindows){
      Global().showInfo(message: body, title: title);
      return;
    }
    const AndroidNotificationDetails androidplatformChannelSpecifics =
    AndroidNotificationDetails(
        'your channel id', 'your channel name',
        importance: Importance.max,
        priority: Priority.high,
        color: Colors.lightBlueAccent,
        ticker: 'ticker');
    const IOSNotificationDetails iOSPlatformChannelSpecifics = IOSNotificationDetails(sound: 'notif.m4r');
    const MacOSNotificationDetails macOSPlatformChannelSpecifics = MacOSNotificationDetails(sound: 'notif.m4r');
    final LinuxNotificationDetails linuxPlatformChannelSpecifics =
    LinuxNotificationDetails(sound: AssetsLinuxSound('sound/desktop.ogg'),);
    final NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidplatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
      macOS: macOSPlatformChannelSpecifics,
      linux: linuxPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin
        .show(0, title, body, platformChannelSpecifics, payload: payload);
    if(GetPlatform.isLinux || GetPlatform.isMacOS){
      Global().showInfo(message: body, title: title);
      return;
    }
  }

}