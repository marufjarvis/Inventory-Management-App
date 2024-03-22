import 'dart:convert';

List<AssetModel> assetModelFromJson(String str) =>
    List<AssetModel>.from(json.decode(str).map((x) => AssetModel.fromJson(x)));

String floorRouteMotesToJson(List<AssetModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AssetModel {
  AssetModel(
      {this.assetName,
      this.thane,
      this.district,
      this.gpsLocation,
      this.floorNo,
      this.roomNo,
      this.createDT,
      this.buildingName,
      this.assetImage});

  String? assetName;
  String? assetImage;
  String? roomNo;
  String? floorNo;
  String? thane;
  String? district;
  String? buildingName;
  String? gpsLocation;
  String? createDT;

  factory AssetModel.fromJson(Map<String, dynamic> json) => AssetModel(
        gpsLocation: json["gpsLocation"],
        thane: json["thane"],
        district: json["district"],
        assetName: json["assetName"],
        floorNo: json["floorNo"],
        roomNo: json["roomNo"],
        buildingName: json["buildingName"],
        createDT: json["createDT"],
        assetImage: json["assetImage"],
      );

  Map<String, dynamic> toJson() => {
        "assetName": assetName,
        "gpsLocation": gpsLocation,
        "district": district,
        "thane": thane,
        "roomNo": roomNo,
        "floorNo": floorNo,
        "buildingName": buildingName,
        "createDT": createDT,
        "assetImage": assetImage,
      };
}
