import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myipond/Controller/DashboardController.dart';

import '../../Widget/CustomAppBar.dart';
import '../../Widget/customWidget.dart';

class HistoryWebScreen extends StatefulWidget {
  @override
  createState() => _HistoryWebScreen();
}

class _HistoryWebScreen extends State<HistoryWebScreen> {
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
        key: key,
        drawer: drawerWeb(),
        body: Column(
          children: [
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
            const SizedBox(height: 15,),
            categoryTitikWidget(Axis.horizontal, 40),
            const SizedBox(height: 15,),

            Row(
              children: [

                Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: Get.height * 0.75,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: data.listAvgHistory.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            elevation: 8.0,
                            margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                            child: Container(
                              decoration: const BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                              child: ListTile(
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                  leading: Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(right: 12.0),
                                        decoration: const BoxDecoration(
                                            border: Border(
                                                right: BorderSide(width: 1.0, color: Colors.white24))),
                                        child: const Icon(Icons.notification_important, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  title: Row(
                                    children: [

                                      const Expanded(
                                        flex: 3,
                                        child: Text(
                                          "ph\n"
                                              "Suhu\n"+
                                              "Kekeruhan",
                                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                        ),
                                      ),

                                      const Expanded(
                                        flex: 1,
                                        child: Text(
                                          ":\n" +
                                              ":\n" +
                                              ":",
                                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                        ),
                                      ),

                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          data.listAvgHistory[index].avgPh + "\n" +
                                              data.listAvgHistory[index].avgSuhu + "\n" +
                                              data.listAvgHistory[index].avgKekeruhan,
                                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                        ),
                                      ),

                                    ],
                                  ),
                                  subtitle: Row(
                                    children: <Widget>[

                                      const Expanded(
                                        flex: 3,
                                        child: Text("Tanggal", style: TextStyle(color: Colors.white),),
                                      ),

                                      const Expanded(
                                        flex: 1,
                                        child: Text(
                                          ":\n:",
                                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                        ),
                                      ),

                                      Expanded(
                                        flex: 2,
                                        child: Text(data.formatter2.format(data.listAvgHistory[index].updatedAt)
                                            // + "\n" + data.formatterJam.format(data.listHistory[index].createdAt)
                                            ,
                                            style: const TextStyle(color: Colors.white)),
                                      ),

                                    ],
                                  ),
                                  trailing: const Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0)),
                            ),
                          );
                        },
                      ),
                    )
                ),

                const Expanded(
                    flex: 3,
                    child: Text("")),

              ],
            ),

          ],
        ),
      );
    });

  }
}
