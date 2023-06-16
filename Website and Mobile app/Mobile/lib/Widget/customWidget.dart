import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myipond/Controller/LoginController.dart';
import 'package:myipond/Controller/OtherController.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../Controller/DashboardController.dart';
import '../Utils/Routes.dart';
List<Color> gradientColors = [
  const Color(0xff23b6e6),
  const Color(0xff02d39a),
];

Widget drawerWeb(){
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        UserAccountsDrawerHeader(
          currentAccountPicture: const CircleAvatar(
            backgroundImage: NetworkImage(
                'https://store.playstation.com/store/api/chihiro/00_09_000/container/US/en/999/UP1018-CUSA00133_00-AV00000000000015/1553561653000/image?w=256&h=256&bg_color=000000&opacity=100&_version=00_09_000'),
          ),
          accountEmail: Text(Get.find<LoginController>().user.user[0].email),
          accountName: Text(
            Get.find<LoginController>().user.user[0].nama,
            style: const TextStyle(fontSize: 24.0),
          ),
          decoration: const BoxDecoration(
            color: Colors.black87,
          ),
        ),
        ListTile(
          leading: const Icon(Icons.house),
          title: const Text(
            'Dashboard',
            style: TextStyle(fontSize: 24.0),
          ),
          onTap: () {

            Get.toNamed(Routes().home);
          },
        ),
        ListTile(
          leading: const Icon(Icons.new_releases_sharp),
          title: const Text(
            'News',
            style: TextStyle(fontSize: 24.0),
          ),
          onTap: () {
            Get.toNamed(Routes().adminnews);
          },
        ),

        ListTile(
          leading: const Icon(Icons.history),
          title: const Text(
            'History',
            style: TextStyle(fontSize: 24.0),
          ),
          onTap: () {
            Get.toNamed(Routes().historyweb);
          },
        ),
      ],
    ),
  );
}

Widget headerView(BuildContext context) {
  return Column(
    children: <Widget>[
      Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
        child: Row(
          children: <Widget>[
            Container(
                width: 48.0,
                height: 48.0,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/images/logo.png")))),
            Container(
                margin: const EdgeInsets.only(left: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "John Witch",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          ?.copyWith(color: Colors.white),
                    ),
                    Text(
                      "test123@gmail.com",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2
                          ?.copyWith(color: Colors.white.withAlpha(200)),
                    )
                  ],
                ))
          ],
        ),
      ),
      Divider(
        color: Colors.white.withAlpha(200),
        height: 16,
      )
    ],
  );
}

Widget categoryTitikWidget(Axis scroll, double height) {
  return GetBuilder<DashboardController>(builder: (data){
    return Row(
      children: [

        Expanded(
          flex: 4,
            child: Container(
                alignment: Alignment.topCenter,
                // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                height:height,
                child: ListView.builder(
                    scrollDirection: scroll,
                    itemCount: data.allHistory.length,
                    itemBuilder: (BuildContext context,int index){
                      return InkWell(
                          onTap: () async {
                            data.initHistory(data.allHistory[index]);
                            data.initDetailStatistik("ph");
                            data.idCard = "1";
                            data.update();
                          },
                          child: Container(
                              margin: const EdgeInsets.only(
                                  left: 8,
                                  bottom: 10
                              ),
                              padding: const EdgeInsets.only(
                                  left: 8, right: 8,
                                  bottom: 6, top: 6
                              ),
                              decoration: BoxDecoration(
                                  color: (data.selectedhistory == null || data.selectedhistory != data.allHistory[index])?
                                  Colors.white :
                                  Colors.lightBlueAccent,
                                  border: Border.all(
                                    color: Colors.red,
                                  ),
                                  borderRadius: const BorderRadius.all(Radius.circular(30))
                              ),
                              child: Center(
                                  child: Text(data.allHistory[index].name,
                                    style: TextStyle(
                                        color: (data.selectedhistory == null || data.selectedhistory != data.allHistory[index])?
                                        Colors.red :
                                        Colors.white
                                    ),
                                  )
                              )
                          )
                      );
                    }
                ))),

        if(DeviceScreenType.mobile == Get.find<LoginController>().typeDevice)
          Expanded(
              flex: 1,
              child: FloatingActionButton(
                onPressed: (){
                  if(data.selectedhistory != null){
                    String url = "https://www.google.com/maps/search/?api=1&query=" + data.selectedhistory!.latitude.toString() +","+ data.selectedhistory!.longitude.toString();
                    Get.find<OtherController>().launchURL(url);
                  }

                },
                child:const Icon(Icons.location_pin)
              )
          ),

        const SizedBox(width: 10,)

      ],
    );
  });

}

Widget leftTitleWidgets(double value, TitleMeta meta) {
  return GetBuilder<DashboardController>(builder: (data){


    const style = TextStyle(
      color: Color(0xff67727d),
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    if(data.maxY - data.minY > 10){
      if(value%5 == 0){
        text = value.toString();
      }else{
        text = "";
      }

    }else{
      text = value.toString();
    }
    // if(data.selectedStatistikMetode == "ph"){
    //   // text = (value.toDouble() * Get.find<OtherController>().rule!.rule[0].minStatistik).toInt().toString();
    //   text = value.toString();
    // }else if (data.selectedStatistikMetode == "suhu"){
    //   // text = (value.toDouble() * Get.find<OtherController>().rule!.rule[1].minStatistik).toInt().toString();
    //   text = value.toString();
    // }else if (data.selectedStatistikMetode == "kekeruhan"){
    //   text = (value.toDouble() * Get.find<OtherController>().rule!.rule[2].minStatistik).toInt().toString();
    //   // if(data.maxY - data.minY > 10){
    //   //   if(value%5 == 0){
    //   //     text = value.toString();
    //   //   }else{
    //   //     text = "";
    //   //   }
    //   //
    //   // }else{
    //   //   text = value.toString();
    //   // }
    //
    // }else{
    //   // text = (value.toDouble() * Get.find<OtherController>().rule!.rule[0].minStatistik).toInt().toString();
    //   text = value.toString();
    // }
    // print(text);

    return Text(text, style: style, textAlign: TextAlign.left);

  });

}

LineChartData mainData(DashboardController data) {
  // print(data.minY);
  // print(data.maxY);
  return LineChartData(
    gridData: FlGridData(
      show: true,
      drawVerticalLine: true,
      horizontalInterval: 1,
      verticalInterval: 1,
      getDrawingHorizontalLine: (value) {
        return FlLine(
          color: const Color(0xff37434d),
          strokeWidth: 1,
        );
      },
      getDrawingVerticalLine: (value) {
        return FlLine(
          color: const Color(0xff37434d),
          strokeWidth: 1,
        );
      },
    ),
    titlesData: FlTitlesData(
      show: true,
      rightTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      topTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 30,
          interval: 1,
          getTitlesWidget: data.generetesTglStatistikWidgets,
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          interval: 1,
          getTitlesWidget: leftTitleWidgets,
          reservedSize: 42,
        ),
      ),
    ),
    borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d), width: 1)),
    minX: 0,
    maxX: 5,
    minY: data.minY,
    maxY: data.maxY,
    lineBarsData: [
      LineChartBarData(
        spots: data.listLine,
        isCurved: true,
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        barWidth: 5,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
      ),
    ],
  );
}

Widget News(DashboardController data){
  return Column(
    children: [

      Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "News",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
      ),
      ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          primary: false,
          shrinkWrap: true,
          itemCount: data.listNews.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                data.selectedNews = data.listNews[index];
                Get.toNamed(Routes().news);
              },
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  padding: const EdgeInsets.all(8),
                  child: Row(children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                            data.listNews[index].gambarfix,
                            width: 100,
                            height: 100,
                            fit: BoxFit.fill)),
                    const SizedBox(width: 10),
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(data.listNews[index].name,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                  maxLines: 3,
                                  textAlign: TextAlign.left),
                              Text(
                                  data.formatter.format(data.listNews[index].createdAt),
                                  style: const TextStyle(
                                      color: Colors.lightBlueAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                  textAlign: TextAlign.left),

                            ]))
                  ])),
            );
          })

    ],
  );
}