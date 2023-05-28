import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/LoginController.dart';
import '../Utils/Routes.dart';

Widget CustomAppBar(BuildContext context, GlobalKey<ScaffoldState> key){

  String nama = "";
  nama = Get.find<LoginController>().user.user[0].nama;

  return Container(
    // height: 258,
    width: MediaQuery.of(context).size.width,
    padding: const EdgeInsets.only(
        top: 10,
        bottom: 10,
        left: 10,
        right: 30.0),
    decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xff669df4), Color(0xff4e80f3)]),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30))),
    child: Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 1,
                child:IconButton(
                    onPressed: (){
                      if (kDebugMode) {
                        print("Jalankan");
                      }
                      key.currentState!.openDrawer();
                    },
                    icon: const Icon(Icons.list)
                ) ,
              ),

              Expanded(
                flex: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'My Ipond',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Hello ' + nama,
                      style: const TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ],
                ),
              ),
              Expanded(
                  flex: 3,
                  child: GestureDetector(
                    child: const CircleAvatar(
                      backgroundImage: AssetImage(
                          'assets/images/logo.png'),
                    ),
                    onTap: () {
                      Get.toNamed(Routes().profilemobile);
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (BuildContext context) => profil()));
                    },
                  )
              ),

            ],
          ),
          // const SizedBox(
          //   height: 40,
          // ),

        ],
      ),
    ),
  );
}