// To parse this JSON data, do
//
//     final buildingResponseModel = buildingResponseModelFromJson(jsonString);

import 'dart:convert';

List<BuildingResponseModel> buildingResponseModelFromJson(String str) =>
    List<BuildingResponseModel>.from(
        json.decode(str).map((x) => BuildingResponseModel.fromJson(x)));

String buildingResponseModelToJson(List<BuildingResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BuildingResponseModel {
  final int id;
  final String name;
  final bool active;

  BuildingResponseModel({
    required this.id,
    required this.name,
    required this.active,
  });

  BuildingResponseModel copyWith({
    int? id,
    String? name,
    bool? active,
  }) =>
      BuildingResponseModel(
        id: id ?? this.id,
        name: name ?? this.name,
        active: active ?? this.active,
      );

  factory BuildingResponseModel.fromJson(Map<String, dynamic> json) =>
      BuildingResponseModel(
        id: json["id"],
        name: json["name"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "active": active,
      };
}
