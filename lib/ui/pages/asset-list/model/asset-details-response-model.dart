// To parse this JSON data, do
//
//     final assetDetailsResponseModel = assetDetailsResponseModelFromJson(jsonString);

import 'dart:convert';

class AssetDetailsResponseModel {
  final int id;
  final String gpsLatitude;
  final String gpsLongitude;
  final DateTime date;
  final String imageUrl;
  final String initialTag;
  final String remarks;
  final String asset;
  final String room;
  final String floor;
  final String building;
  final String thana;
  final String district;
  final String? addedBy;

  AssetDetailsResponseModel(
      {required this.id,
      required this.gpsLatitude,
      required this.gpsLongitude,
      required this.date,
      required this.imageUrl,
      required this.initialTag,
      required this.remarks,
      required this.asset,
      required this.room,
      required this.floor,
      required this.building,
      required this.thana,
      required this.district,
      this.addedBy});

  AssetDetailsResponseModel copyWith({
    int? id,
    String? gpsLatitude,
    String? gpsLongitude,
    DateTime? date,
    String? imageUrl,
    String? initialTag,
    String? remarks,
    String? asset,
    String? room,
    String? floor,
    String? building,
    String? thana,
    String? district,
    String? addedBy,
  }) =>
      AssetDetailsResponseModel(
        id: id ?? this.id,
        gpsLatitude: gpsLatitude ?? this.gpsLatitude,
        gpsLongitude: gpsLongitude ?? this.gpsLongitude,
        date: date ?? this.date,
        imageUrl: imageUrl ?? this.imageUrl,
        initialTag: initialTag ?? this.initialTag,
        remarks: remarks ?? this.remarks,
        asset: asset ?? this.asset,
        room: room ?? this.room,
        floor: floor ?? this.floor,
        building: building ?? this.building,
        thana: thana ?? this.thana,
        district: district ?? this.district,
        addedBy: addedBy ?? "",
      );

  factory AssetDetailsResponseModel.fromRawJson(String str) =>
      AssetDetailsResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AssetDetailsResponseModel.fromJson(Map<String, dynamic> json) =>
      AssetDetailsResponseModel(
        id: json["id"],
        gpsLatitude: json["gps_latitude"],
        gpsLongitude: json["gps_longitude"],
        date: DateTime.parse(json["date"]),
        imageUrl: json["image_url"],
        initialTag: json["initial_tag"],
        remarks: json["remarks"],
        asset: json["asset"],
        room: json["room"],
        floor: json["floor"],
        building: json["building"],
        thana: json["thana"],
        district: json["district"],
        addedBy: json["addedBy"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "gps_latitude": gpsLatitude,
        "gps_longitude": gpsLongitude,
        "date": date.toIso8601String(),
        "image_url": imageUrl,
        "initial_tag": initialTag,
        "remarks": remarks,
        "asset": asset,
        "room": room,
        "floor": floor,
        "building": building,
        "thana": thana,
        "district": district,
        "addedBy": addedBy,
      };
}
