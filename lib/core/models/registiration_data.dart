// To parse this JSON data, do
//
//     final registiration = registirationFromJson(jsonString);

import 'dart:convert';

Registration registrationFromJson(String str) =>
    Registration.fromJson(json.decode(str));

String registrationToJson(Registration data) => json.encode(data.toJson());

class Registration {
  bool success;
  String message;
  UserSignUpData data;

  Registration({
    this.success,
    this.message,
    this.data,
  });

  factory Registration.fromJson(Map<String, dynamic> json) => Registration(
        data: UserSignUpData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class UserSignUpData {
  String name;
  String password;
  String email;
  String passwordConfirmation;

  UserSignUpData({
    this.name,
    this.password,
    this.email,
    this.passwordConfirmation,
  });

  factory UserSignUpData.fromJson(Map<String, dynamic> json) => UserSignUpData(
        name: json["name"],
        email: json["email"],
        password: json["password"],
        passwordConfirmation: json["password confirmation"],
      );

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = name;
    map["email"] = email;
    map["password"] = password;
    map["password confirmation"] = passwordConfirmation;
    return map;
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
        "password confirmation": passwordConfirmation,
      };
}

class Response {
  int id;
  String name;
  String token;
  String email;
  String createdAt;

  Response({
    this.id,
    this.name,
    this.token,
    this.email,
    this.createdAt,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        id: json["id"],
        name: json["name"],
        token: json["token"],
        email: json["email"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "token": token,
        "email": email,
        "created_at": createdAt,
      };
}
