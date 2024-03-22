// ignore_for_file: file_names

import 'dart:convert';

List<BuildingModel> buildingModelFromJson(String str) =>
    List<BuildingModel>.from(
        json.decode(str).map((x) => BuildingModel.fromJson(x)));

String buildingModelsToJson(List<BuildingModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BuildingModel {
  BuildingModel({this.id, this.name, this.thanaid});

  String? id;
  String? name;
  String? thanaid;

  factory BuildingModel.fromJson(Map<String, dynamic> json) => BuildingModel(
        id: json["id"],
        name: json["name"],
        thanaid: json["thana_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "thana_id": thanaid,
      };
}
