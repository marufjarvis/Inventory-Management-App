// To parse this JSON data, do
//
//     final floorResponseModel = floorResponseModelFromJson(jsonString);

import 'dart:convert';

FloorResponseModel floorResponseModelFromJson(String str) =>
    FloorResponseModel.fromJson(json.decode(str));

String floorResponseModelToJson(FloorResponseModel data) =>
    json.encode(data.toJson());

class FloorResponseModel {
  final int id;
  final String name;
  final bool active;
  final int buildingId;
  final DateTime updatedAt;
  final DateTime createdAt;

  FloorResponseModel({
    required this.id,
    required this.name,
    required this.active,
    required this.buildingId,
    required this.updatedAt,
    required this.createdAt,
  });

  FloorResponseModel copyWith({
    int? id,
    String? name,
    bool? active,
    int? buildingId,
    DateTime? updatedAt,
    DateTime? createdAt,
  }) =>
      FloorResponseModel(
        id: id ?? this.id,
        name: name ?? this.name,
        active: active ?? this.active,
        buildingId: buildingId ?? this.buildingId,
        updatedAt: updatedAt ?? this.updatedAt,
        createdAt: createdAt ?? this.createdAt,
      );

  factory FloorResponseModel.fromJson(Map<String, dynamic> json) =>
      FloorResponseModel(
        id: json["id"],
        name: json["name"],
        active: json["active"],
        buildingId: json["buildingId"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "active": active,
        "buildingId": buildingId,
        "updatedAt": updatedAt.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
      };
}
