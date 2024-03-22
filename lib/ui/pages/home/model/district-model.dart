// To parse this JSON data, do
//
//     final districtLists = districtListsFromJson(jsonString);

import 'dart:convert';

List<DistrictModel> districtModelsFromJson(String str) =>
    List<DistrictModel>.from(
        json.decode(str).map((x) => DistrictModel.fromJson(x)));

String districtModelsToJson(List<DistrictModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DistrictModel {
  DistrictModel({this.id, this.name, this.createdAt, this.updatedAt});

  String? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  factory DistrictModel.fromJson(Map<String, dynamic> json) => DistrictModel(
        id: json["id"],
        name: json["name"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toJson() =>
      {"id": id, "name": name, "createdAt": createdAt, "updatedAt": updatedAt};
}

class DistrictModelNew {
  DistrictModelNew({this.id, this.name, this.createdAt, this.updatedAt});

  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  factory DistrictModelNew.fromJson(Map<String, dynamic> json) =>
      DistrictModelNew(
        id: json["id"] as int,
        name: json["name"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toJson() =>
      {"id": id, "name": name, "createdAt": createdAt, "updatedAt": updatedAt};
}
