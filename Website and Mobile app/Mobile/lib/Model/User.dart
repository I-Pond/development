import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.user,
  });

  List<UserElement> user;

  factory User.fromJson(Map<String, dynamic> json) => User(
    user: List<UserElement>.from(json["user"].map((x) => UserElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "user": List<dynamic>.from(user.map((x) => x.toJson())),
  };
}

class UserElement {
  UserElement({
    required this.fcm,
    required this.id,
    required this.nama,
    required this.akses,
    required this.email,
  });

  String fcm;
  String id;
  String nama;
  String akses;
  String email;

  factory UserElement.fromJson(Map<String, dynamic> json) => UserElement(
    fcm: json["fcm"],
    id: json["id"],
    nama: json["nama"],
    akses: json["akses"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "fcm": fcm,
    "id": id,
    "nama": nama,
    "akses": akses,
    "email": email,
  };
}
