// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) =>
    json.encode(data.toJson());

class LoginResponseModel {
  final String message;
  final Data data;

  LoginResponseModel({
    required this.message,
    required this.data,
  });

  LoginResponseModel copyWith({
    String? message,
    Data? data,
  }) =>
      LoginResponseModel(
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  final String tokenType;
  final String token;

  Data({
    required this.tokenType,
    required this.token,
  });

  Data copyWith({
    String? tokenType,
    String? token,
  }) =>
      Data(
        tokenType: tokenType ?? this.tokenType,
        token: token ?? this.token,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        tokenType: json["tokenType"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "tokenType": tokenType,
        "token": token,
      };
}
