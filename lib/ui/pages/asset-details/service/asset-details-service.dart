// ignore_for_file: prefer_typing_uninitialized_variables, depend_on_referenced_packages

import "dart:convert";
import "dart:io";
import 'package:shared_preferences/shared_preferences.dart';
import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "package:inventory_mangament_app/constatns/api.dart";
import "package:inventory_mangament_app/ui/pages/add-building-asset/model/error-response-model.dart";
import "package:inventory_mangament_app/ui/pages/asset-list/model/asset-details-response-model.dart";
import "package:inventory_mangament_app/ui/pages/asset-list/model/asset-request-model.dart";

import "../../../../constatns/string.dart";

class AssetDetailsService {
  // var d = {
  //   "name": "Mobile",
  //   "gps_latitude": "121212",
  //   "gps_longitude": "2323",
  //   "date": "2017-08-22T06:11:00.000Z",
  //   "image_url": "www.image.com",
  //   "initial_tag": "123",
  //   "remarks": "My Samsung S8",
  //   "asset": {"id": 10}
  // };

  static Future<bool> addAssetDetail(
      String roomId, AssetRequestModel data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //var response;
    String url = "${globalUrl}user/rooms/$roomId/asset_details/";

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer ${prefs.getString(token)}"
    };

    var response;
    try {
      var dataEncodeJson = jsonEncode(data.toJson());
      print(dataEncodeJson);
      response = await http.post(Uri.parse(url),
          body: dataEncodeJson, headers: headers);

      debugPrint(response.statusCode.toString());
    } on SocketException {
      debugPrint("No Internet Connection");
    } catch (e) {
      debugPrint(e.toString());
    }

    print(response.statusCode);

    if (response.statusCode == 200) {
      debugPrint(response.body);

      return true;
    } else {
      //token error
      ErrorResponseModel errorResponseModel =
          errorResponseModelFromJson(response.body);
      if (errorResponseModel.message.toLowerCase().contains("jwt")) {
        print("Token Expired");
      }
      throw Exception("Token Error");
    }
  }

  static Future<List<AssetDetailsResponseModel>> allAssetDetails(
      String roomid) async {
    //var response;
    String url = "${globalUrl}user/rooms/$roomid/asset_details/";

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    var response;
    try {
      response = await http.get(Uri.parse(url), headers: headers);

      debugPrint(response.body);
      debugPrint(response.statusCode);
    } on SocketException {
      print("get all building");
      debugPrint("No Internet Connection");
    } catch (e) {
      debugPrint(e.toString());
    }

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);

      //Creating a list to store input data;
      List<AssetDetailsResponseModel> buildingList = [];
      for (var assetDetail in responseData) {
        AssetDetailsResponseModel user = AssetDetailsResponseModel(
          id: assetDetail["id"] as int,
          //  name: assetDetail["name"],
          gpsLatitude: assetDetail["gps_latitude"],
          gpsLongitude: assetDetail["gps_longitude"],
          date: DateTime.parse(assetDetail["date"]),
          imageUrl: assetDetail["image_url"],
          initialTag: assetDetail["initial_tag"],
          remarks: assetDetail["remarks"],
          asset: assetDetail["asset"],
          room: assetDetail["room"],
          floor: assetDetail["floor"],
          building: assetDetail["building"],
          thana: assetDetail["thana"],
          district: assetDetail["district"],
          addedBy: assetDetail["addedBy"],
        );

        //Adding user to the list.
        buildingList.add(user);
      }

      return buildingList;
    } else {
      //token error
      ErrorResponseModel errorResponseModel =
          errorResponseModelFromJson(response.body);
      if (errorResponseModel.message.toLowerCase().contains("jwt")) {
        debugPrint("Token Expired");
      }
      throw Exception("Token Error");
    }
  }

  static Future<bool> deleteAssetDetail(
      String roomId, String assetDetailId) async {
    //var response;
    String url = "${globalUrl}user/rooms/$roomId/asset_details/$assetDetailId";

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    var response;
    try {
      response = await http.delete(Uri.parse(url), headers: headers);

      debugPrint(response.statusCode);
    } on SocketException {
      debugPrint("No Internet Connection");
    } catch (e) {
      debugPrint(e.toString());
    }

    if (response.statusCode == 200) {
      return true;
    } else {
      //token error
      ErrorResponseModel errorResponseModel =
          errorResponseModelFromJson(response.body);
      if (errorResponseModel.message.toLowerCase().contains("jwt")) {
        debugPrint("Token Expired");
      }
      throw Exception("Token Error");
    }
  }
}
