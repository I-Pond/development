import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myipond/Controller/DashboardController.dart';
import 'package:myipond/Utils/Routes.dart';
class NewsScreen extends StatelessWidget {
  DashboardController dashboardController = Get.put(DashboardController());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Get.toNamed(Routes().home);
        Get.back();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "News My-Ipond",
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      width: Get.width,
                      height: 300,
                      padding: const EdgeInsets.all(10),
                      child: FittedBox(
                        child: Image.network(
                          dashboardController.selectedNews!.gambarfix,
                          fit: BoxFit.fitWidth,
                        ),
                        fit: BoxFit.fill,
                      )),
                  const SizedBox(height: 15),
                  Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Text(dashboardController.selectedNews!.name,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18))),
                  const SizedBox(height: 10),
                  Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Text(dashboardController.selectedNews!.content,
                          style: const TextStyle(color: Colors.black, fontSize: 16
                          )
                      )
                  ),


                  const SizedBox(height: 50),
                ])),
      ),
    );
  }
}
