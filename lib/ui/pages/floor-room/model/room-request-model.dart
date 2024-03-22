// To parse this JSON data, do
//
//     final RoomRequestModel = RoomRequestModelFromJson(jsonString);

import 'dart:convert';

RoomRequestModel roomRequestModelFromJson(String str) =>
    RoomRequestModel.fromJson(json.decode(str));

String roomRequestModelToJson(RoomRequestModel data) =>
    json.encode(data.toJson());

class RoomRequestModel {
  final String name;
  final bool active;
  final int floorId;

  RoomRequestModel({
    required this.name,
    required this.active,
    required this.floorId,
  });

  RoomRequestModel copyWith({
    String? name,
    bool? active,
    int? floorId,
  }) =>
      RoomRequestModel(
        name: name ?? this.name,
        active: active ?? this.active,
        floorId: floorId ?? this.floorId,
      );

  factory RoomRequestModel.fromJson(Map<String, dynamic> json) =>
      RoomRequestModel(
        name: json["name"],
        active: json["active"],
        floorId: json["floorId"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "active": active,
        "floorId": floorId,
      };
}
