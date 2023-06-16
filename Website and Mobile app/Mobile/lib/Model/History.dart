import 'dart:convert';

import 'package:flutter/foundation.dart';

List<History> historyFromJson(String str) => List<History>.from(json.decode(str).map((x) => History.fromJson(x)));

String historyToJson(List<History> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class History {
  History({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.titikHistory,
    required this.totalavgph,
    required this.totalavgsuhu,
    required this.totalavgkekeruhan,
    required this.latitude,
    required this.longitude,
  });

  String id;
  String name;
  DateTime createdAt;
  TitikHistory titikHistory;
  double totalavgph;
  double totalavgsuhu;
  double totalavgkekeruhan;
  double latitude;
  double longitude;

  factory History.fromJson(Map<String, dynamic> json) {

    return History(
      id: json["id"],
      name: json["name"],
      createdAt: DateTime.parse(json["created_at"]),
      titikHistory: TitikHistory.fromJson(json["titikHistory"]),
      // totalavgph: double.parse(json["totalavgph"].toStringAsFixed(2)),
      // totalavgsuhu: double.parse(json["totalavgsuhu"].toStringAsFixed(2)),
      // totalavgkekeruhan: double.parse(json["totalavgkekeruhan"].toStringAsFixed(2)),
      totalavgph: double.parse(json["totalavgph"]),
      totalavgsuhu: double.parse(json["totalavgsuhu"]),
      totalavgkekeruhan: double.parse(json["totalavgkekeruhan"]),
      latitude: double.parse(json["latitude"]),
      longitude: double.parse(json["longitude"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "created_at": createdAt.toIso8601String(),
    "titikHistory": titikHistory.toJson(),
    "totalavgph": totalavgph,
    "totalavgsuhu": totalavgsuhu,
    "totalavgkekeruhan": totalavgkekeruhan,
    "latitude": latitude,
    "longitude": longitude,
  };
}

class TitikHistory {
  TitikHistory({
    required this.history,
    required this.avgHistory,
  });

  List<HistoryElement> history;
  List<AvgHistory> avgHistory;

  factory TitikHistory.fromJson(Map<String, dynamic> json) => TitikHistory(
    history: List<HistoryElement>.from(json["history"].map((x) => HistoryElement.fromJson(x))),
    avgHistory: List<AvgHistory>.from(json["avg_history"].map((x) => AvgHistory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "history": List<dynamic>.from(history.map((x) => x.toJson())),
    "avg_history": List<dynamic>.from(avgHistory.map((x) => x.toJson())),
  };
}

class AvgHistory {
  AvgHistory({
    required this.id,
    required this.avgPh,
    required this.avgSuhu,
    required this.avgKekeruhan,
    required this.updatedAt,
  });

  String id;
  String avgPh;
  String avgSuhu;
  String avgKekeruhan;
  DateTime updatedAt;

  factory AvgHistory.fromJson(Map<String, dynamic> json) {
    if (kDebugMode) {
      print(json['avg_ph']);
    }
    String ph = "0";
    String suhu = '0';
    String kekeruhan = '0';
    if(json["avg_ph"].toString().contains(".")){
      ph = json["avg_ph"];
      if(json["avg_ph"].toString().split(".").last.length > 1){
        ph = double.parse(json['avg_ph']).toStringAsFixed(2).toString();
      }
      if(json["avg_suhu"].toString().split(".").last.length > 1){
        suhu = double.parse(json['avg_suhu']).toStringAsFixed(2).toString();
      }
      if(json["avg_kekeruhan"].toString().split(".").last.length > 1){
        kekeruhan = double.parse(json['avg_kekeruhan']).toStringAsFixed(2).toString();
      }


    }
    return AvgHistory(
      id: json["id"],
      avgPh: ph,
      avgSuhu: suhu,
      avgKekeruhan: kekeruhan,
      updatedAt: DateTime.parse(json["updated_at"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "avg_ph": avgPh,
    "avg_suhu": avgSuhu,
    "avg_kekeruhan": avgKekeruhan,
    "updated_at": updatedAt.toIso8601String(),
  };
}

class HistoryElement {
  HistoryElement({
    required this.id,
    required this.suhu,
    required this.ph,
    required this.kekeruhan,
    required this.createdAt,
  });

  String id;
  String suhu;
  String ph;
  String kekeruhan;
  DateTime createdAt;

  factory HistoryElement.fromJson(Map<String, dynamic> json) => HistoryElement(
    id: json["id"],
    suhu: json["suhu"],
    ph: json["ph"],
    kekeruhan: json["kekeruhan"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "suhu": suhu,
    "ph": ph,
    "kekeruhan": kekeruhan,
    "created_at": createdAt.toIso8601String(),
  };
}
