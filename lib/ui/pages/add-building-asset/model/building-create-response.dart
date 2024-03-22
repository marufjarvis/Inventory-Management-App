// To parse this JSON data, do
//
//     final buildingResponseModel = buildingResponseModelFromJson(jsonString);

import 'dart:convert';

BuildingCreateResponseModel buildingResponseModelFromJson(String str) =>
    BuildingCreateResponseModel.fromJson(json.decode(str));

String buildingResponseModelToJson(BuildingCreateResponseModel data) =>
    json.encode(data.toJson());

class BuildingCreateResponseModel {
  final int id;
  final String name;
  final bool active;
  // final int? thanaId;
  // final DateTime? updatedAt;
  // final DateTime? createdAt;

  BuildingCreateResponseModel({
    required this.id,
    required this.name,
    required this.active,
    // required this.thanaId,
    // required this.updatedAt,
    // required this.createdAt,
  });

  BuildingCreateResponseModel copyWith({
    int? id,
    String? name,
    bool? active,
    int? thanaId,
    DateTime? updatedAt,
    DateTime? createdAt,
  }) =>
      BuildingCreateResponseModel(
        id: id ?? this.id,
        name: name ?? this.name,
        active: active ?? this.active,
        // thanaId: thanaId ?? this.thanaId,
        // updatedAt: updatedAt ?? this.updatedAt,
        // createdAt: createdAt ?? this.createdAt,
      );

  factory BuildingCreateResponseModel.fromJson(Map<String, dynamic> json) =>
      BuildingCreateResponseModel(
        id: json["id"] as int,
        name: json["name"],
        active: json["active"] as bool,
        // thanaId: json["thanaId"] as int,
        // updatedAt: json["updatedAt"] as DateTime,
        // createdAt: json["createdAt"] as DateTime,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "active": active,
        // "thanaId": thanaId,
        // "updatedAt": updatedAt!.toIso8601String(),
        // "createdAt": createdAt!.toIso8601String(),
      };
}
