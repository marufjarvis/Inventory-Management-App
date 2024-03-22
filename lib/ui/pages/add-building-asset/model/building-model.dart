// To parse this JSON data, do
//
//     final buildingModel = buildingModelFromJson(jsonString);

import 'dart:convert';

BuildingModel buildingModelFromJson(String str) =>
    BuildingModel.fromJson(json.decode(str));

String buildingModelToJson(BuildingModel data) => json.encode(data.toJson());

class BuildingModel {
  final String name;
  final bool active;

  BuildingModel({
    required this.name,
    required this.active,
  });

  BuildingModel copyWith({
    String? name,
    bool? active,
  }) =>
      BuildingModel(
        name: name ?? this.name,
        active: active ?? this.active,
      );

  factory BuildingModel.fromJson(Map<String, dynamic> json) => BuildingModel(
        name: json["name"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "active": active,
      };
}
