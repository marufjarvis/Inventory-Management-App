// ignore_for_file: prefer_typing_uninitialized_variables

import "dart:convert";
import "dart:io";

import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "package:inventory_mangament_app/constatns/api.dart";

import "package:inventory_mangament_app/ui/pages/add-building-asset/model/error-response-model.dart";
import "package:inventory_mangament_app/ui/pages/floor-room/model/room-request-model.dart";
import "package:inventory_mangament_app/ui/pages/floor-room/model/room-response-model.dart";

class RoomService {
  static Future<bool> addRoom(String floorId, RoomRequestModel data) async {
    //var response;
    String url = "${globalUrl}user/floors/$floorId/rooms/";

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

  static Future<List<RoomResponseModel>> allRoombyFloor(String floorId) async {
    //var response;
    String url = "${globalUrl}user/floors/$floorId/rooms/";

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
      List<RoomResponseModel> buildingList = [];
      for (var building in responseData) {
        RoomResponseModel user = RoomResponseModel(
          id: building["id"] as int,
          name: building["name"],
          active: building["active"],
          floorId: building["floorId"],
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

  static Future<bool> deleteRoom(String roomId, String floorId) async {
    //var response;
    String url = "${globalUrl}user/floors/$floorId/rooms/$roomId";

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

  Future<bool> updateRoom(String roomId, String floorId, String value) async {
    final Map<String, dynamic> updatedData = {'name': value};

    final response = await http.put(
      Uri.parse('${globalUrl}user/floors/$floorId/rooms/$roomId'),
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
