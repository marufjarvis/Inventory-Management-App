// To parse this JSON data, do
//
//     final RoomResponseModel = RoomResponseModelFromJson(jsonString);

import 'dart:convert';

RoomResponseModel roomResponseModelFromJson(String str) =>
    RoomResponseModel.fromJson(json.decode(str));

String roomResponseModelToJson(RoomResponseModel data) =>
    json.encode(data.toJson());

class RoomResponseModel {
  final int id;
  final String name;
  final bool active;
  final int floorId;
  final DateTime updatedAt;
  final DateTime createdAt;

  RoomResponseModel({
    required this.id,
    required this.name,
    required this.active,
    required this.floorId,
    required this.updatedAt,
    required this.createdAt,
  });

  RoomResponseModel copyWith({
    int? id,
    String? name,
    bool? active,
    int? floorId,
    DateTime? updatedAt,
    DateTime? createdAt,
  }) =>
      RoomResponseModel(
        id: id ?? this.id,
        name: name ?? this.name,
        active: active ?? this.active,
        floorId: floorId ?? this.floorId,
        updatedAt: updatedAt ?? this.updatedAt,
        createdAt: createdAt ?? this.createdAt,
      );

  factory RoomResponseModel.fromJson(Map<String, dynamic> json) =>
      RoomResponseModel(
        id: json["id"],
        name: json["name"],
        active: json["active"],
        floorId: json["floorId"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "active": active,
        "floorId": floorId,
        "updatedAt": updatedAt.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
      };
}
