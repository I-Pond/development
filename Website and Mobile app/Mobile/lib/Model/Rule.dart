import 'dart:convert';

Rule ruleFromJson(String str) => Rule.fromJson(json.decode(str));

String ruleToJson(Rule data) => json.encode(data.toJson());

class Rule {
  Rule({
    required this.rule,
  });

  List<RuleElement> rule;

  factory Rule.fromJson(Map<String, dynamic> json) => Rule(
    rule: List<RuleElement>.from(json["rule"].map((x) => RuleElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "rule": List<dynamic>.from(rule.map((x) => x.toJson())),
  };
}

class RuleElement {
  RuleElement({
    required this.id,
    required this.type,
    required this.minValue,
    required this.maxValue,
    required this.minStatistik,
    required this.ket,
    required this.createdAt,
  });

  String id;
  String type;
  double minValue;
  double maxValue;
  double minStatistik;
  String ket;
  DateTime createdAt;

  factory RuleElement.fromJson(Map<String, dynamic> json) => RuleElement(
    id: json["id"],
    type: json["type"],
    minValue: double.parse(json["min_value"]),
    maxValue: double.parse(json["max_value"]),
    minStatistik: json["minStatistik"],
    ket: json["ket"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "min_value": minValue.toString(),
    "max_value": maxValue.toString(),
    "minStatistik" : minStatistik,
    "ket": ket,
    "created_at": createdAt.toIso8601String(),
  };
}
