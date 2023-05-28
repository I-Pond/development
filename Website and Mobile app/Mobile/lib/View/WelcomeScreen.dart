import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myipond/Controller/LoginController.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'Mobile/DashboardMobileScreen.dart';
import 'User/LoginScreen.dart';
import 'Web/DashboardWebScreen.dart';

class WelcomeScreen extends StatefulWidget {

  @override
  State<WelcomeScreen> createState() => _WelcomeScreen();
}

class _WelcomeScreen extends State<WelcomeScreen> {

  var loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {

    return GetBuilder<LoginController>(builder: (data){
      return WillPopScope(
        onWillPop: ()=>data.onExit(),
        child: ResponsiveBuilder(
          builder: (context, sizingInformation) {
            if(!data.islogin){
              return LoginScreen();
            }else{

              if (sizingInformation.deviceScreenType == DeviceScreenType.desktop && data.user.user[0].akses == "admin") {
                return DashboardWebScreen();
              }

              if (sizingInformation.deviceScreenType == DeviceScreenType.tablet && data.user.user[0].akses == "admin") {
                return DashboardWebScreen();
              }

              if (sizingInformation.deviceScreenType == DeviceScreenType.mobile && data.user.user[0].akses == "admin") {
                return DashboardWebScreen();
              }

              if (sizingInformation.deviceScreenType == DeviceScreenType.watch) {
                return DashboardMobileScreen();
              }

              return DashboardMobileScreen();
            }

          },
        ),
      );
    });
  }
}
