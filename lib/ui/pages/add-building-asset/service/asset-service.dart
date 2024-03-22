// ignore_for_file: prefer_typing_uninitialized_variables

import "dart:convert";
import "dart:io";

import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "package:inventory_mangament_app/constatns/api.dart";
import "package:inventory_mangament_app/ui/pages/add-building-asset/model/building-create-response.dart";
import "package:inventory_mangament_app/ui/pages/add-building-asset/model/building-model.dart";
import "package:inventory_mangament_app/ui/pages/add-building-asset/model/error-response-model.dart";

class AssetService {
  static Future<bool> addAsset(BuildingModel data) async {
    //var response;
    String url = "${globalUrl}admin/assets";

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    var response;
    try {
      var dataEncodeJson = jsonEncode(data.toJson());

      response = await http.post(Uri.parse(url),
          body: dataEncodeJson, headers: headers);

      debugPrint(response.statusCode);
    } on SocketException {
      debugPrint("No Internet Connection");
    } catch (e) {
      debugPrint(e.toString());
    }

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

  static Future<List<BuildingCreateResponseModel>> allAsset() async {
    //var response;
    String url = "${globalUrl}admin/assets";

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    var response;
    try {
      response = await http.get(Uri.parse(url), headers: headers);

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
      List<BuildingCreateResponseModel> buildingList = [];
      for (var building in responseData) {
        BuildingCreateResponseModel user = BuildingCreateResponseModel(
          id: building["id"] as int,
          name: building["name"],
          active: building["active"],
          // createdAt: building["createdAt"] ?? DateTime(2023),
          // thanaId: building["thanaId"] ?? 0,
          // updatedAt: building["updatedAt"] ?? DateTime(2023),
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

  static Future<bool> deleteAsset(String assetId) async {
    //var response;
    String url = "${globalUrl}admin/assets/$assetId";

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

  Future<bool> updateAsset(String value, String assetId) async {
    final Map<String, dynamic> updatedData = {'name': value};

    final response = await http.put(
      Uri.parse('${globalUrl}admin/assets/$assetId'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(updatedData),
    );

    if (response.statusCode == 200) {
      // Update request successful
      return true;
    } else {
      // Handle error
      return false;
    }
  }
}
