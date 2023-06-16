import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:myipond/Controller/DashboardController.dart';

import '../../Widget/customWidget.dart';

class StatistikScreen extends StatefulWidget {
  // const LineChartSample2({Key? key}) : super(key: key);

  @override
  _StatistikScreen createState() => _StatistikScreen();
}

class _StatistikScreen extends State<StatistikScreen> {

  @override
  void initState() {
    // TODO: implement initState
    initStatistik();

    super.initState();
  }
  initStatistik() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    await Future.delayed(const Duration(seconds: 1));
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (data){
      return WillPopScope(onWillPop: () async {
        await SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);

        Get.back();

        return await true;
      },
        child: Scaffold(
            backgroundColor: const Color(0xff232d37),
            appBar: AppBar(
              backgroundColor: const Color(0xff232d37),
              title: const Text("Detail"),
              leading: IconButton(
                onPressed: (){
                  SystemChrome.setPreferredOrientations([
                    DeviceOrientation.portraitUp,
                    DeviceOrientation.portraitDown,
                  ]);

                  Get.back();
                },
                icon: const Icon(Icons.arrow_back_ios),
              ),
            ),
            body: Stack(
              children: <Widget>[
                Container(
                  width: Get.width,
                  height: Get.height * 0.9,
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

              ],
            )
        ),
      );
    });
  }

}