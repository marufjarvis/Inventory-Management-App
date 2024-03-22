// ignore_for_file: prefer_typing_uninitialized_variables

import "dart:convert";
import "dart:io";

import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "package:inventory_mangament_app/constatns/api.dart";

import "package:inventory_mangament_app/ui/pages/add-building-asset/model/error-response-model.dart";
import "package:inventory_mangament_app/ui/pages/floor-room/model/floor-request-model.dart";
import "package:inventory_mangament_app/ui/pages/floor-room/model/floor-response-model.dart";

class FloorService {
  static Future<bool> addFloor(
      String buildingId, FloorRequestModel data) async {
    //var response;
    String url = "${globalUrl}user/buildings/$buildingId/floors/";

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

  static Future<List<FloorResponseModel>> allBuildign(String buildingId) async {
    //var response;
    String url = "${globalUrl}user/buildings/$buildingId/floors/";

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
      List<FloorResponseModel> buildingList = [];
      for (var building in responseData) {
        FloorResponseModel user = FloorResponseModel(
          id: building["id"] as int,
          name: building["name"],
          active: building["active"],
          buildingId: building["buildingId"],
          createdAt: DateTime.parse(building["createdAt"]),
          updatedAt: DateTime.parse(building["updatedAt"]),
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

  static Future<bool> deleteFloor(String floorId, String buildingId) async {
    //var response;
    String url = "${globalUrl}user/buildings/$buildingId/floors/$floorId";

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

  Future<bool> updateFloor(
      String floorId, String buildingId, String value) async {
    final Map<String, dynamic> updatedData = {'name': value};

    final response = await http.put(
      Uri.parse('${globalUrl}user/buildings/$buildingId/floors/$floorId'),
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
