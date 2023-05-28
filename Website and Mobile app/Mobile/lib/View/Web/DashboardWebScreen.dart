import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myipond/Controller/DashboardController.dart';
import 'package:myipond/Widget/CustomAppBar.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../Controller/LoginController.dart';
import '../../Controller/OtherController.dart';
import '../../Utils/Routes.dart';
import '../../Widget/customWidget.dart';
class DashboardWebScreen extends StatefulWidget {
  @override
  createState() => _DashboardWebScreen();
}

class _DashboardWebScreen extends State<DashboardWebScreen> {

  GlobalKey<ScaffoldState>? key;

  @override
  void initState() {
    // TODO: implement initState
    key = GlobalKey<ScaffoldState>();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    key = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return GetBuilder<DashboardController>(builder: (data){
      return Scaffold(
        backgroundColor: Colors.grey[400],
        key: key,
        drawer: drawerWeb(),
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
              Container(
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
                child: CustomAppBar(context, key!),
              ),
              // _roomCategories(),
              // _applianceGrid()
              const SizedBox(height: 30,),
              Container(
                padding: const EdgeInsets.only(
                  left: 12, right: 12
                ),
                child: Row(
                  children: [

                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if(DeviceScreenType.mobile == Get.find<LoginController>().typeDevice)
                            FloatingActionButton(
                                onPressed: (){
                                  if(data.selectedhistory != null){
                                    String url = "https://www.google.com/maps/search/?api=1&query=" + data.selectedhistory!.latitude.toString() +","+ data.selectedhistory!.longitude.toString();
                                    Get.find<OtherController>().launchURL(url);
                                  }

                                },
                                child:const Icon(Icons.location_pin)
                            ),
                          categoryTitikWidget(Axis.vertical, 120),
                          _applianceGrid(),

                        ],
                      )
                    ),

                    const SizedBox(
                      width: 20,
                    ),

                    if(data.allHistory.isEmpty)
                      Expanded(
                        flex: 6,
                          child:SizedBox(
                            height: Get.height * 0.1,
                            child: const CircularProgressIndicator(),
                          )
                      ),

                    if(data.allHistory.isNotEmpty)
                      Expanded(
                        flex: 6,
                        child: Container(
                          width: Get.width,
                          height: Get.height * 0.8,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(18),
                              ),
                              color: Color(0xff232d37)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: 18.0, left: 12.0, top: 24, bottom: 12),
                            child: LineChart(mainData(data)
                            ),
                          ),
                        ),
                      ),

                  ],
                )
              ),

            ])
        )
      );
    });
  }

  Widget _buildApplianceCard(int index) {
    return GetBuilder<DashboardController>(builder: (data){
      return Container(
        // height: Get.height * 0.1,
        width: Get.width * 0.4,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: const EdgeInsets.fromLTRB(15, 2.5, 7.5, 8),
        // index % 4 == 0
        //     ? const EdgeInsets.fromLTRB(15, 2.5, 7.5, 2.5)
        //     : const EdgeInsets.fromLTRB(7.5, 2.5, 15, 2.5),
        decoration: BoxDecoration(
            boxShadow: const <BoxShadow>[
              BoxShadow(
                  blurRadius: 10, offset: Offset(0, 10), color: Color(0xfff1f0f2))
            ],
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: (data.idCard != data.listCardMonitor[index].id)?[const Color(0xff669df4), const Color(0xff4e80f3)]
                :[const Color(0xffd03a6a), const Color(0xff820e33)]
            ),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(data.listCardMonitor[index].leftIcon,
                    color: Colors.white),
                // Switch(
                //     value: data.listCardMonitor[index].isEnable,
                //     activeColor: const Color(0xff457be4),
                //     onChanged: (_) {
                //       data.listCardMonitor[index].isEnable = !data.listCardMonitor[index].isEnable;
                //       data.update();
                //     })
              ],
            ),
            const SizedBox(
              height: 15,
              width: 45,
            ),
            Text(
              data.listCardMonitor[index].title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              data.listCardMonitor[index].subtitle,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20),
            ),
            // Icon(model.allYatch[index].topRightIcon,color:model.allYatch[index].isEnable ? Colors.white : Color(0xffa3a3a3))
          ],
        ),
      );
    });

  }

  Widget _applianceGrid() {
    return GetBuilder<DashboardController>(builder: (data){
      return Container(
          alignment: Alignment.topCenter,
          // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          height:400,
          child: ListView.builder(
            // physics: const NeverScrollableScrollPhysics(),
            // mainAxisSpacing: 10,
            // crossAxisSpacing: 10,
              scrollDirection: Axis.vertical,
              itemCount: data.listCardMonitor.length,
              itemBuilder: (BuildContext context,int index){
                return InkWell(
                    onTap: () async {
                      String metode = "";
                      if (kDebugMode) {
                        print(data.listCardMonitor[index].id);
                      }
                      data.idCard = data.listCardMonitor[index].id;
                      if(data.listCardMonitor[index].id == "1"){
                        metode = "ph";
                      }else if(data.listCardMonitor[index].id == "2"){
                        metode = "suhu";
                      }else if(data.listCardMonitor[index].id == "3"){
                        metode = "kekeruhan";
                      }
                      data.initDetailStatistik(metode);
                      data.update();
                      // Get.toNamed(Routes().statistik);
                    },
                    child: _buildApplianceCard(index)
                );
              }
          ));
    });

  }

}
