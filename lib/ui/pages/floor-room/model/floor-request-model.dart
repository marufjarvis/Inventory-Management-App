// To parse this JSON data, do
//
//     final floorRequestModel = floorRequestModelFromJson(jsonString);

import 'dart:convert';

FloorRequestModel floorRequestModelFromJson(String str) =>
    FloorRequestModel.fromJson(json.decode(str));

String floorRequestModelToJson(FloorRequestModel data) =>
    json.encode(data.toJson());

class FloorRequestModel {
  final String name;
  final bool active;
  final int buildingId;

  FloorRequestModel({
    required this.name,
    required this.active,
    required this.buildingId,
  });

  FloorRequestModel copyWith({
    String? name,
    bool? active,
    int? buildingId,
  }) =>
      FloorRequestModel(
        name: name ?? this.name,
        active: active ?? this.active,
        buildingId: buildingId ?? this.buildingId,
      );

  factory FloorRequestModel.fromJson(Map<String, dynamic> json) =>
      FloorRequestModel(
        name: json["name"],
        active: json["active"],
        buildingId: json["buildingId"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "active": active,
        "buildingId": buildingId,
      };
}
