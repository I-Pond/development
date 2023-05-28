import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myipond/Controller/LoginController.dart';
import 'package:myipond/Controller/OtherController.dart';

import '../../Utils/Global.dart';
import '../../Utils/Routes.dart';

class ProfileMobileScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text("Profile"),
        // ),
        body: Container(
          height: Get.height,
          color: Colors.white,
          width: Get.width,
          padding: const EdgeInsets.fromLTRB(40.0, 40, 40, 70),
          child:SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 80,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: const Text(
                    'Profile',
                    style: TextStyle(fontSize: 43, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(75),
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                            offset: Offset(10, 15),
                            color: Color(0x22000000),
                            blurRadius: 20.0)
                      ],
                      image: const DecorationImage(
                          image: AssetImage(
                              'assets/images/logo.png'))),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'my i-Pond',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 50,
                ),

                InkWell(
                    onTap: () async {
                      // await Get.find<LoginController>().logoutProses();
                      Get.find<OtherController>().title = "About Us";
                      Get.find<OtherController>().isi = "Kami adalah";
                      Get.toNamed(Routes().aboutus);
                    },
                    child: const ListTile(
                      leading: Icon(Icons.info,
                        size: 40,
                      ),
                      title: Text("About Us",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      trailing: Icon(Icons.keyboard_double_arrow_right,
                        size: 40,
                      ),
                    )
                ),

                InkWell(
                    onTap: () async {
                      if(GetPlatform.isIOS){
                        Global().showInfo(message: "Mohon maaf untuk IOS belum tersedia", title: "Info");
                      }else{
                        Get.find<OtherController>().directUrl("https://play.google.com/store/apps/details?id=com.myipond.myipond");
                      }
                    },
                    child: const ListTile(
                      leading: Icon(Icons.play_arrow,
                        size: 40,
                      ),
                      title: Text("Review Aplikasi",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      trailing: Icon(Icons.keyboard_double_arrow_right,
                        size: 40,
                      ),
                    )
                ),

                InkWell(
                    onTap: () async {
                      await Get.find<LoginController>().logoutProses();
                      Get.toNamed(Routes().home);
                    },
                    child: const ListTile(
                      leading: Icon(Icons.door_back_door_outlined,
                        size: 40,
                      ),
                      title: Text("Logout",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      trailing: Icon(Icons.keyboard_double_arrow_right,
                        size: 40,
                      ),
                    )
                ),

              ],
            ),
          ),
        ));
  }

  Widget placeContainer(String title, Color color, bool leftIcon) {
    return Column(
      children: <Widget>[
        Container(
            height: 60,
            width: Get.width - 40,
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: color),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                      color: leftIcon ? const Color(0xffa3a3a3) : Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
                leftIcon
                    ? const Icon(
                        Icons.add,
                        color: Color(0xffa3a3a3),
                      )
                    : Container()
              ],
            ))
      ],
    );
  }


}
