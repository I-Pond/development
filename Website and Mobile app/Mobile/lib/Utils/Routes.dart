import 'package:get/get.dart';
import 'package:myipond/View/Mobile/HistoryMobileScreen.dart';
import 'package:myipond/View/Mobile/ProfileMobileScreen.dart';
import 'package:myipond/View/Mobile/StatistikScreen.dart';
import 'package:myipond/View/Other/AboutUsScreen.dart';
import 'package:myipond/View/Other/NewsScreen.dart';
import 'package:myipond/View/User/ForgotPasswordScreen.dart';
import 'package:myipond/View/Web/AdminNewsScreen.dart';
import 'package:myipond/View/Web/HistoryWebScreen.dart';
import '../View/User/RegisterScreen.dart';
import '../View/WelcomeScreen.dart';
import '../main.dart';

class Routes {
  final home              = "/";
  final register          = "/register";
  final forgotpass        = "/forgotpass";
  final history           = "/history";
  final historyweb        = "/historyweb";
  final profilemobile     = "/profilemobile";
  final news              = "/news";
  final statistik         = "/statistik";
  final adminnews         = "/adminnews";
  final aboutus           = "/aboutus";

  List<GetPage> listPage = [
    GetPage(name: '/',                      page: () => WelcomeScreen()),
    GetPage(name: '/register',              page: () => RegisterScreen()),
    GetPage(name: '/forgotpass',            page: () => ForgotPasswordScreen()),
    GetPage(name: '/history',               page: () => HistoryMobileScreen()),
    GetPage(name: '/historyweb',            page: () => HistoryWebScreen()),
    GetPage(name: '/profilemobile',         page: () => ProfileMobileScreen()),
    GetPage(name: '/news',                  page: () => NewsScreen()),
    GetPage(name: '/statistik',             page: () => StatistikScreen()),
    GetPage(name: '/adminnews',             page: () => AdminNewsScreen()),
    GetPage(name: '/aboutus',               page: () => AboutUsScreen()),
  ];
}
