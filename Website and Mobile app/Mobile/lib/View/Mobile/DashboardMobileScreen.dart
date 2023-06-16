import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myipond/Controller/DashboardController.dart';
import 'package:myipond/Controller/LoginController.dart';
import 'package:myipond/Utils/Routes.dart';
import '../../Controller/OtherController.dart';
import '../../Widget/customWidget.dart';

class DashboardMobileScreen extends StatelessWidget {
  var otherController = Get.put(OtherController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (data){
      return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
              Container(
                // height: 258,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 50,
                    bottom: 30,
                    left: 30,
                    right: 30.0),
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xff669df4), Color(0xff4e80f3)]),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
                child: _upperContainer(data),
              ),
              // _roomCategories(),
              const SizedBox(height: 15,),
              categoryTitikWidget(Axis.horizontal, 40),
              const SizedBox(height: 15,),
              _applianceGrid(),
              const SizedBox(height: 20,),
              News(data),
            ])
        )
      );
    });
  }

  Widget _upperContainer(DashboardController data) {
    String nama = "";
    nama = Get.find<LoginController>().user.user[0].nama;
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
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
              GestureDetector(
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
            ],
          ),
          const SizedBox(
            height: 40,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(25)),
                child: const Icon(
                  Icons.timer,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  Row(
                    children: <Widget>[
                      Text(
                        data.timeString,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  ),

                ],
              )
            ],
          ),

          const SizedBox(height: 10,),

          InkWell(
            onTap: (){
              Get.toNamed(Routes().history);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.white),
                      borderRadius: BorderRadius.circular(25)),
                  child: const Icon(
                    Icons.timelapse,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Row(
                      children: const <Widget>[
                        Text(
                          'History',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w900),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    ),

                  ],
                )
              ],
            )
          ),

        ],
      ),
    );
  }

  Widget _buildApplianceCard(int index) {
    return GetBuilder<DashboardController>(builder: (data){
      if(otherController.rule == null){
        return Container();
      }
      if(data.listCardMonitor[index].title == "ph"){
        int cekPh = otherController.cekStatus(otherController.rule!.rule[0].minValue,
            otherController.rule!.rule[0].minValue,
            double.parse(data.listCardMonitor[index].subtitle)
        );
      }

      if(data.listCardMonitor[index].title == "ph"){
        int cekSuhu = otherController.cekStatus(otherController.rule!.rule[1].minValue,
            otherController.rule!.rule[1].minValue,
            double.parse(data.listCardMonitor[index].subtitle)
        );
      }

      if(data.listCardMonitor[index].title == "ph"){
        int cekKekeruhan = otherController.cekStatus(otherController.rule!.rule[2].minValue,
            otherController.rule!.rule[2].minValue,
            double.parse(data.listCardMonitor[index].subtitle)
        );
      }

      return Container(
        // height: Get.height * 0.1,
        width: Get.width * 0.4,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: index % 4 == 0
            ? const EdgeInsets.fromLTRB(15, 2.5, 7.5, 2.5)
            : const EdgeInsets.fromLTRB(7.5, 2.5, 15, 2.5),
        decoration: BoxDecoration(
            boxShadow: const <BoxShadow>[
              BoxShadow(
                  blurRadius: 10, offset: Offset(0, 10), color: Color(0xfff1f0f2))
            ],
            gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xff669df4), Color(0xff4e80f3)]),
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
          height:150,
          child: ListView.builder(
            // physics: const NeverScrollableScrollPhysics(),
            // mainAxisSpacing: 10,
            // crossAxisSpacing: 10,
            scrollDirection: Axis.horizontal,
            itemCount: data.listCardMonitor.length,
            itemBuilder: (BuildContext context,int index){
              return InkWell(
                onTap: () async {
                  String metode = "";
                  if (kDebugMode) {
                    print(data.listCardMonitor[index].id);
                  }
                  if(data.listCardMonitor[index].id == "1"){
                    metode = "ph";
                  }else if(data.listCardMonitor[index].id == "2"){
                    metode = "suhu";
                  }else if(data.listCardMonitor[index].id == "3"){
                    metode = "kekeruhan";
                  }
                  data.initDetailStatistik(metode);
                  Get.toNamed(Routes().statistik);
                },
                child: _buildApplianceCard(index)
              );
            }
          ));
    });

  }
}
