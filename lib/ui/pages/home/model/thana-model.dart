// ignore_for_file: file_names

import 'dart:convert';

import 'package:inventory_mangament_app/ui/pages/home/model/district-model.dart';

List<ThanaModel> thanaListsFromJson(String str) =>
    List<ThanaModel>.from(json.decode(str).map((x) => ThanaModel.fromJson(x)));

String thanaListsToJson(List<ThanaModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ThanaModel {
  ThanaModel({this.districtId, this.name, this.id});

  String? districtId;
  String? name;
  String? id;

  factory ThanaModel.fromJson(Map<String, dynamic> json) => ThanaModel(
        districtId: json["district_id"],
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "district_id": districtId,
        "name": name,
        "id": id,
      };
}

class ThanaModelNew {
  final int id;
  final String name;
  final String createdAt;
  final String updatedAt;
  final int districtId;
  final DistrictModelNew district;

  ThanaModelNew({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.districtId,
    required this.district,
  });

  ThanaModelNew copyWith({
    int? id,
    String? name,
    String? createdAt,
    String? updatedAt,
    int? districtId,
    DistrictModelNew? district,
  }) =>
      ThanaModelNew(
        id: id ?? this.id,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        districtId: districtId ?? this.districtId,
        district: district ?? this.district,
      );

  factory ThanaModelNew.fromRawJson(String str) =>
      ThanaModelNew.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ThanaModelNew.fromJson(Map<String, dynamic> json) => ThanaModelNew(
        id: json["id"],
        name: json["name"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        districtId: json["districtId"],
        district: DistrictModelNew.fromJson(json["district"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "districtId": districtId,
        "district": district.toJson(),
      };
}
