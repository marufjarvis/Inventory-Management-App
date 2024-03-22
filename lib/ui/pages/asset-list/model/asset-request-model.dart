// To parse this JSON data, do
//
//     final assetRequestModel = assetRequestModelFromJson(jsonString);

import 'dart:convert';

AssetRequestModel assetRequestModelFromJson(String str) =>
    AssetRequestModel.fromJson(json.decode(str));

String assetRequestModelToJson(AssetRequestModel data) =>
    json.encode(data.toJson());

class AssetRequestModel {
  final String name;
  final String gpsLatitude;
  final String gpsLongitude;
  final DateTime date;
  final String imageUrl;
  final String initialTag;
  final String remarks;
  final Asset asset;

  AssetRequestModel({
    required this.name,
    required this.gpsLatitude,
    required this.gpsLongitude,
    required this.date,
    required this.imageUrl,
    required this.initialTag,
    required this.remarks,
    required this.asset,
  });

  AssetRequestModel copyWith(
          {String? name,
          String? gpsLatitude,
          String? gpsLongitude,
          DateTime? date,
          String? imageUrl,
          String? initialTag,
          String? remarks,
          Asset? asset,
          String? addedBy}) =>
      AssetRequestModel(
        name: name ?? this.name,
        gpsLatitude: gpsLatitude ?? this.gpsLatitude,
        gpsLongitude: gpsLongitude ?? this.gpsLongitude,
        date: date ?? this.date,
        imageUrl: imageUrl ?? this.imageUrl,
        initialTag: initialTag ?? this.initialTag,
        remarks: remarks ?? this.remarks,
        asset: asset ?? this.asset,
      );

  factory AssetRequestModel.fromJson(Map<String, dynamic> json) =>
      AssetRequestModel(
        name: json["name"],
        gpsLatitude: json["gps_latitude"],
        gpsLongitude: json["gps_longitude"],
        date: DateTime.parse(json["date"]),
        imageUrl: json["image_url"],
        initialTag: json["initial_tag"],
        remarks: json["remarks"],
        asset: Asset.fromJson(json["asset"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "gps_latitude": gpsLatitude,
        "gps_longitude": gpsLongitude,
        "date": date.toIso8601String(),
        "image_url": imageUrl,
        "initial_tag": initialTag,
        "remarks": remarks,
        "asset": asset.toJson(),
      };
}

class Asset {
  final int id;

  Asset({
    required this.id,
  });

  Asset copyWith({
    int? id,
  }) =>
      Asset(
        id: id ?? this.id,
      );

  factory Asset.fromJson(Map<String, dynamic> json) => Asset(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
