import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:myipond/Controller/OtherController.dart';
import 'package:myipond/Model/History.dart';
import 'package:myipond/Model/News.dart';
import 'package:myipond/Utils/Api.dart';
import 'package:http/http.dart' as http;
import 'package:responsive_builder/responsive_builder.dart';
import '../Model/appliance.dart';
import '../Utils/Firebase.dart';
import '../Utils/Global.dart';
import 'package:http_parser/http_parser.dart';

class DashboardController extends GetxController{
  List<HistoryElement> listHistory = [];
  List<AvgHistory> listAvgHistory = [];
  List<History> allHistory = [];
  History? selectedhistory;
  News? news;
  List<NewsElement> listNews = [];
  DateFormat formatter = DateFormat('yyyy-MM-dd');
  DateFormat formatterJam = DateFormat('HH:mm');
  DateFormat formatter2 = DateFormat('dd-MM-yyyy');
  DateTime now = DateTime.now();
  double avgSuhu = 0, avgPh = 0, avgKekeruhan = 0;
  NewsElement? selectedNews;
  List<FlSpot> listLine = [];
  List<String> listTglStatistik = [];
  List<Appliance> listCardMonitor = [];
  DateTime tglStart = DateTime.now();
  DateTime tglEnd = DateTime.now();
  String idCard = "1";
  TextEditingController judulNewsController = TextEditingController();
  TextEditingController isiNewsController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  XFile? imageFile;
  String? retrieveDataError;
  dynamic pickImageError;
  String timeString = "";
  String selectedStatistikMetode = "ph";
  double maxY = 0;
  double minY = 0;

  @override
  void onInit() {
    // TODO: implement onInit
    tglStart = DateTime(now.year, now.month, now.day);
    tglEnd = DateTime(now.year, now.month, now.day+1);
    getHistory();
    getNews();
    Timer.periodic(const Duration(seconds: 1), (Timer t) => getTime());
    super.onInit();
  }

  initDetailStatistik(String metode){

    selectedStatistikMetode = metode;
    listLine = [];
    listTglStatistik = [];

    if(metode == "ph"){
      maxY = Get.find<OtherController>().rule!.rule[0].maxValue;
      minY = Get.find<OtherController>().rule!.rule[0].minValue;
    }
    if(metode == "suhu"){
      maxY = Get.find<OtherController>().rule!.rule[1].maxValue;
      minY = Get.find<OtherController>().rule!.rule[1].minValue;
    }
    if(metode == "kekeruhan"){
      maxY = Get.find<OtherController>().rule!.rule[2].maxValue;
      minY = Get.find<OtherController>().rule!.rule[2].minValue;
    }
    if (kDebugMode) {
      print(minY);
      print(maxY);
    }

    String tempePh = Get.find<OtherController>().rule!.rule[0].minValue.toString();
    String tempSuhu = Get.find<OtherController>().rule!.rule[1].minValue.toString();
    String tempKekeruhan = Get.find<OtherController>().rule!.rule[2].minValue.toString();
    List<AvgHistory> listStatistik = [];
    for(int indexStatistik =0; indexStatistik<=listHistory.length-1; indexStatistik++){
      if(indexStatistik > 6){
        break;
      }
      listStatistik.add(AvgHistory
        (id: listHistory[indexStatistik].id, avgPh: listHistory[indexStatistik].ph, avgSuhu: listHistory[indexStatistik].suhu,
          avgKekeruhan: listHistory[indexStatistik].kekeruhan, updatedAt: listHistory[indexStatistik].createdAt)
      );
    }
    listStatistik = listStatistik.reversed.toList();

    if(listStatistik.length > 6){

      int hasilConvert = listStatistik.length~/7;
      if (kDebugMode) {
        print("hasil convert : " + hasilConvert.toString());
        // print("Masuk 1");
      }

      for(int index=0; index<= 6; index++){
        // String value = "50";
        String valuePh = tempePh;
        String valueSuhu = tempSuhu;
        String valueKekeruhan = tempKekeruhan;
        if(index == 0){
          if(metode == "ph"){
            if(listStatistik[0].avgPh != "0"){
              valuePh = listStatistik[0].avgPh;
            }
            double cek = double.parse(valuePh)/double.parse(tempePh);
            listLine.add(FlSpot(index.toDouble(), double.parse(valuePh)));
          }else if(metode == "suhu"){
            if(listStatistik[0].avgSuhu != "0"){
              valueSuhu = listStatistik[0].avgSuhu;
            }
            double cek = double.parse(valueSuhu)/double.parse(tempSuhu);
            // listLine.add(FlSpot(index.toDouble(), cek.toDouble()));
            listLine.add(FlSpot(index.toDouble(), double.parse(valueSuhu)));
          }else if(metode == "kekeruhan"){
            if(listStatistik[0].avgKekeruhan != "0"){
              valueKekeruhan = listStatistik[0].avgKekeruhan;
            }
            double cek = double.parse(valueKekeruhan)/double.parse(tempKekeruhan);
            // listLine.add(FlSpot(index.toDouble(), cek.toDouble()));
            listLine.add(FlSpot(index.toDouble(), double.parse(valueKekeruhan)));
          }
          listTglStatistik.add(formatterJam.format(listStatistik[0].updatedAt));
        }else if( index == 6){
          if(metode == "ph"){
            if(listStatistik[listStatistik.length-1].avgPh != "0"){
              valuePh = listStatistik[listStatistik.length-1].avgPh;
            }
            double cek = double.parse(valuePh)/double.parse(tempePh);
            // listLine.add(FlSpot(index.toDouble(), cek.toDouble()));
            listLine.add(FlSpot(index.toDouble(), double.parse(valuePh)));
          }else if(metode == "suhu"){
            if(listStatistik[listStatistik.length-1].avgSuhu != "0"){
              valueSuhu = listStatistik[listStatistik.length-1].avgSuhu;
            }
            double cek = double.parse(valueSuhu)/double.parse(tempSuhu);
            // listLine.add(FlSpot(index.toDouble(), cek.toDouble()));
            listLine.add(FlSpot(index.toDouble(), double.parse(valueSuhu)));
          }else if(metode == "kekeruhan"){
            if(listStatistik[listStatistik.length-1].avgKekeruhan != "0"){
              valueKekeruhan = listStatistik[listStatistik.length-1].avgKekeruhan;
            }
            double cek = double.parse(valueKekeruhan)/double.parse(tempKekeruhan);
            // listLine.add(FlSpot(index.toDouble(), cek.toDouble()));
            listLine.add(FlSpot(index.toDouble(), double.parse(valueKekeruhan)));
          }
          listTglStatistik.add(formatterJam.format(listStatistik[listStatistik.length-1].updatedAt));
        }else{
          if(metode == "ph"){
            if(listStatistik[index * hasilConvert].avgPh != "0"){
              valuePh = listStatistik[index * hasilConvert].avgPh;
            }
            double cek = double.parse(valuePh)/double.parse(tempePh);
            // listLine.add(FlSpot(index.toDouble(), cek.toDouble()));
            listLine.add(FlSpot(index.toDouble(), double.parse(valuePh)));
          }else if(metode == "suhu"){
            if(listStatistik[index * hasilConvert].avgSuhu != "0"){
              valueSuhu = listStatistik[index * hasilConvert].avgSuhu;
            }
            double cek = double.parse(valueSuhu)/double.parse(tempSuhu);
            // listLine.add(FlSpot(index.toDouble(), cek.toDouble()));
            listLine.add(FlSpot(index.toDouble(), double.parse(valueSuhu)));
          }else if(metode == "kekeruhan"){
            if(listStatistik[index * hasilConvert].avgKekeruhan != "0"){
              valueKekeruhan = listStatistik[index * hasilConvert].avgKekeruhan;
            }
            double cek = double.parse(valueKekeruhan)/double.parse(tempKekeruhan);
            // listLine.add(FlSpot(index.toDouble(), cek.toDouble()));
            listLine.add(FlSpot(index.toDouble(), double.parse(valueKekeruhan)));
          }
          listTglStatistik.add(formatterJam.format(listStatistik[index * hasilConvert].updatedAt));
        }

      }

    }else{
      // print("Masuk 2");
      for(int index=0; index<= 6; index++){

        String valuePh = tempePh;
        String valueSuhu = tempSuhu;
        String valueKekeruhan = tempKekeruhan;
        if(index <= listStatistik.length-1){
          if(metode == "ph"){
            if(listStatistik[index].avgPh != "0"){
              valuePh = listStatistik[index].avgPh;
            }
            double cek = double.parse(valuePh)/double.parse(tempePh);
            // listLine.add(FlSpot(index.toDouble(), cek.toDouble()));
            listLine.add(FlSpot(index.toDouble(), double.parse(valuePh)));
          }else if(metode == "suhu"){
            if(listStatistik[index].avgSuhu != "0"){
              valueSuhu = listStatistik[index].avgSuhu;
            }
            double cek = double.parse(valueSuhu)/double.parse(tempSuhu);
            // listLine.add(FlSpot(index.toDouble(), cek.toDouble()));
            listLine.add(FlSpot(index.toDouble(), double.parse(valueSuhu)));
          }else if(metode == "kekeruhan"){
            if(listStatistik[index].avgKekeruhan != "0"){
              valueKekeruhan = listStatistik[index].avgKekeruhan;
            }
            double cek = double.parse(valueKekeruhan)/double.parse(tempKekeruhan);
            // listLine.add(FlSpot(index.toDouble(), cek.toDouble()));
            listLine.add(FlSpot(index.toDouble(), double.parse(valueKekeruhan)));
          }
          listTglStatistik.add(formatterJam.format(listStatistik[index].updatedAt));

        }else{
          if(metode == "ph"){
            listLine.add(FlSpot(index.toDouble(), double.parse(tempePh)));
          }else if(metode == "suhu"){
            listLine.add(FlSpot(index.toDouble(),  double.parse(tempSuhu)));
          }else if(metode == "kekeruhan"){
            listLine.add(FlSpot(index.toDouble(),  double.parse(tempKekeruhan)));
          }
          listTglStatistik.add("");
        }
      }
    }
    // listLine.add(const FlSpot(7, 0));
    listTglStatistik.add("");
    if (kDebugMode) {
      print(listLine);
    }
  }

  Widget generetesTglStatistikWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff68737d),
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    text = Text(listTglStatistik[value.toInt()], style: style);
    return Padding(child: text, padding: const EdgeInsets.only(top: 8.0));
  }

  getHistory() async {
    // DateTime dateTimeStart = DateTime(now.year, now.month, now.day - 7);
    // DateTime dateTimeEnd = DateTime(now.year, now.month, now.day+1);
    DateTime dateTimeStart = tglStart;
    DateTime dateTimeEnd = tglEnd;
    String dateStart  = formatter.format(dateTimeStart);
    String dateEnd    = formatter.format(dateTimeEnd);
    String url        = "history";
    String param      = "date_start=$dateStart&date_end=$dateEnd";
    listCardMonitor = [];
    var response = await Api().get(url, param);
    if(response != null){
      // if (kDebugMode) {
      //   print(response.body);
      // }
      allHistory = historyFromJson(response.body);
      if(allHistory.isNotEmpty && allHistory[0].titikHistory.history.isNotEmpty){
        initHistory(allHistory[0]);
      }
    }
    await Get.find<OtherController>().getRule();
    initDetailStatistik("ph");
    update();
    if (kDebugMode) {
      print(allHistory);
    }

  }
  
  initHistory(History selected){
    selectedhistory = selected;
    listAvgHistory.assignAll(selectedhistory!.titikHistory.avgHistory);
    avgPh         = selectedhistory!.totalavgph;
    avgSuhu       = selectedhistory!.totalavgsuhu;
    avgKekeruhan  = selectedhistory!.totalavgkekeruhan;
    initListCardMonitor();
    listHistory.assignAll(selectedhistory!.titikHistory.history);
  }

  getNews() async {

    String url        = "other/news";
    String param      = "";
    var response = await Api().get(url, param);
    if(response != null){
      if (kDebugMode) {
        print(response.body);
      }
      news = newsFromJson(response.body);
      if(news!.news.isNotEmpty){
        listNews.assignAll(news!.news);
      }
    }

    update();
  }

  initListCardMonitor(){
    listCardMonitor = [];
    listCardMonitor.add(Appliance(
        title: 'ph',
        subtitle: avgPh.toString(),
        leftIcon: Icons.height,
        topRightIcon: Icons.threesixty,
        bottomRightIcon: Icons.threesixty,
        isEnable: false,
        id: "1"),);
    listCardMonitor.add(Appliance(
        title: 'Suhu',
        subtitle: avgSuhu.toString() + ' C',
        leftIcon: Icons.thermostat,
        topRightIcon: Icons.threesixty,
        bottomRightIcon: Icons.threesixty,
        isEnable: true,
        id: "2")
    );

    listCardMonitor.add(Appliance(
        title: 'Kekeruhan',
        subtitle: avgKekeruhan.toString() + ' %',
        leftIcon: Icons.water,
        topRightIcon: Icons.threesixty,
        bottomRightIcon: Icons.threesixty,
        isEnable: true,
        id: '3'));

  }

  showNotif(String Message, String title) async {

    if(kIsWeb){
      Global().showInfo(message: Message, title: title);
    }else if(GetPlatform.isWindows){
      Global().showInfo(message: Message, title: title);
    }else{

      if(GetPlatform.isLinux || GetPlatform.isMacOS){
        Global().showInfo(message: Message, title: title);
      }
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
        'your other channel id',
        'your other channel name',
        channelDescription: 'your other channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        sound: RawResourceAndroidNotificationSound('notif'),
      );
      const IOSNotificationDetails iOSPlatformChannelSpecifics =
      IOSNotificationDetails(sound: 'notif.m4r');
      const MacOSNotificationDetails macOSPlatformChannelSpecifics =
      MacOSNotificationDetails(sound: 'notif.m4r');
      final LinuxNotificationDetails linuxPlatformChannelSpecifics =
      LinuxNotificationDetails(
        sound: AssetsLinuxSound('sound/desktop.ogg'),
      );

      final NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics,
        macOS: macOSPlatformChannelSpecifics,
        linux: linuxPlatformChannelSpecifics,
      );

      await flutterLocalNotificationsPlugin.show(0, title,
        Message, platformChannelSpecifics,
      );
    }

  }
  
  uploadNews(BuildContext context) async {

    if(judulNewsController.text.isEmpty || isiNewsController.text.isEmpty ||
    imageFile == null){
      ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
              type: ArtSweetAlertType.info,
              title: "Info",
              text: "Silahkan isi field yang kosong terlebih dahulu"
          )
      );
    }else{
      Global().showLoading("Mengirim data");
      var urlS = Api().urlApi + "other/tambah_news";
      if (kDebugMode) {
        // print(header);
        print("ambil data PostMultipart : $urlS");
      }
      final request = http.MultipartRequest(
        "POST",
        Uri.parse(urlS),
      );
      // -----add other fields if needed
      request.fields["name"] = judulNewsController.text;
      request.fields["content"] = isiNewsController.text;
      var streamFile = await imageFile!.readAsBytes();
      //-----add selected file with request
      request.files.add(http.MultipartFile.fromBytes(
          'file',
          streamFile,
          filename: imageFile!.name,
          contentType: MediaType('*', '*')
      ));
      if (kDebugMode) {
        print(request);
      }
      var result = await Api().postMultipart(request);
      Global().dismissLoading();
      if(result.statusCode == 200){
        //------Read response
        String body = await result.stream.bytesToString();
        if (kDebugMode) {
          print(body);
        }
        var data = json.decode(body);
        imageFile = null;
        await getNews();
        update();
        ArtSweetAlert.show(
            context: context,
            artDialogArgs: ArtDialogArgs(
                type: ArtSweetAlertType.success,
                title: "Sukses",
                text: data["info"]
            )
        );

      }else{
        ArtSweetAlert.show(
            context: context,
            artDialogArgs: ArtDialogArgs(
                type: ArtSweetAlertType.info,
                title: "Info",
                text: "Tidak berhasil upload News"
            )
        );
      }

      if (kDebugMode) {
        print(result);
      }
    }
    
  }

  editNews(BuildContext context, String id) async {

    if(judulNewsController.text.isEmpty || isiNewsController.text.isEmpty){
      ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
              type: ArtSweetAlertType.info,
              title: "Info",
              text: "Silahkan isi field yang kosong terlebih dahulu"
          )
      );
    }else{
      Global().showLoading("Mengirim data");
      var urlS = Api().urlApi + "other/edit_news";
      if (kDebugMode) {
        // print(header);
        print("ambil data PostMultipart : $urlS");
      }
      final request = http.MultipartRequest(
        "POST",
        Uri.parse(urlS),
      );
      // -----add other fields if needed
      request.fields["id"]      = id;
      request.fields["name"]    = judulNewsController.text;
      request.fields["content"] = isiNewsController.text;
      if(imageFile != null){
        var streamFile = await imageFile!.readAsBytes();
        //-----add selected file with request
        request.files.add(http.MultipartFile.fromBytes(
            'file',
            streamFile,
            filename: imageFile!.name,
            contentType: MediaType('*', '*')
        ));
      }
      if (kDebugMode) {
        print(request.fields);
        print(request.files);
      }
      var result = await Api().postMultipart(request);
      String body = await result.stream.bytesToString();
      if (kDebugMode) {
        print(body);
      }
      Global().dismissLoading();
      if(result.statusCode == 200){
        //------Read response
        var data = json.decode(body);
        imageFile = null;
        ArtSweetAlert.show(
            context: context,
            artDialogArgs: ArtDialogArgs(
                type: ArtSweetAlertType.success,
                title: "Sukses",
                text: data["info"]
            )
        );

        await getNews();
        update();

      }else{
        ArtSweetAlert.show(
            context: context,
            artDialogArgs: ArtDialogArgs(
                type: ArtSweetAlertType.info,
                title: "Info",
                text: "Tidak berhasil upload News"
            )
        );
      }

      if (kDebugMode) {
        print(result);
      }
    }

  }

  deleteNews(BuildContext context, String id) async {

    Global().showLoading("Memuat Data");

    String urlPath = "other/delete_news";
    var body = {
      "id"     : id,
    };
    var response = await Api().post(urlPath, body);
    Global().dismissLoading();
    if (kDebugMode) {
      print(response.body);
    }
    if(response != null){

      var data = json.decode(response.body);
      if(data['status'] == true){
        await getNews();
        update();
        ArtSweetAlert.show(
            context: context,
            artDialogArgs: ArtDialogArgs(
                type: ArtSweetAlertType.success,
                title: "Sukses",
                text: data["info"]
            )
        );
      }else{
        ArtSweetAlert.show(
            context: context,
            artDialogArgs: ArtDialogArgs(
                type: ArtSweetAlertType.info,
                title: "Failed",
                text: data["info"]
            )
        );
      }
    }

  }

  pickImage() async {
    imageFile = await picker.pickImage(source: ImageSource.gallery);
    if(imageFile != null){
      if (kDebugMode) {
        print("Dapet Image");
        print(imageFile);
      }
      update();
    }

  }

  Widget previewImages() {
    final Text? retrieveError = getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (imageFile != null) {
      return Semantics(
          child: kIsWeb
              ? Image.network(imageFile!.path)
              : Image.file(File(imageFile!.path)),
          label: 'Gambar berita');
    } else if (pickImageError != null) {
      return Text(
        'Pick image error: $pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return const Text(
        'You have not yet picked an image.',
        textAlign: TextAlign.center,
      );
    }
  }

  Text? getRetrieveErrorWidget() {
    if (retrieveDataError != null) {
      final Text result = Text(retrieveDataError!);
      retrieveDataError = null;
      return result;
    }
    return null;
  }

  void getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = formatDateTime(now);
    timeString = formattedDateTime;
    update();
  }

  String formatDateTime(DateTime dateTime) {
    return DateFormat('MM-dd-yyyy\nhh:mm:ss').format(dateTime);
  }

}