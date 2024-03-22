// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_mangament_app/constatns/color.dart';
import 'package:inventory_mangament_app/ui/pages/floor-room/model/floor-model.dart';
import 'package:inventory_mangament_app/ui/pages/floor-room/model/floor-request-model.dart';
import 'package:inventory_mangament_app/ui/pages/floor-room/model/floor-response-model.dart';
import 'package:inventory_mangament_app/ui/pages/floor-room/model/room-request-model.dart';
import 'package:inventory_mangament_app/ui/pages/floor-room/model/room-response-model.dart';
import 'package:inventory_mangament_app/ui/pages/floor-room/service/floor-service.dart';
import 'package:inventory_mangament_app/ui/pages/floor-room/service/room-serivice.dart';

class FloorRoomController extends GetxController {
  FloorRouteMotel routeItemInfo = Get.arguments;

  var floorID = "none".obs;
  //var roomID = "none".obs;
  var floorList = <FloorResponseModel>[].obs;
  var roomList = <RoomResponseModel>[].obs;
  final TextEditingController textEditingController = TextEditingController();
  final TextEditingController updateEditingController = TextEditingController();
  var isLoading = false.obs;

  void getFloor(String buldingId) async {
    isLoading.value = true;
    print("hi");
    print(buldingId);
    var list =
        (await FloorService.allBuildign(buldingId)).cast<FloorResponseModel>();

    print(floorList.length);
    //buildingList.add(building!);
    isLoading.value = false;
    floorList.value = list;
    print(floorList.length);
  }

  bool isAlradyNameExistOnList(dynamic d, List<dynamic> list) {
    for (var item in list) {
      if (item.name.toLowerCase() == d.name.toLowerCase()) {
        return true;
      }
    }
    return false;
  }

  void addNewFloor(String id, FloorRequestModel data) async {
    if (isAlradyNameExistOnList(data, floorList)) {
      Get.snackbar("Ops", "This name alrady exist",
          colorText: whiteColor, backgroundColor: Colors.red);
    } else {
      isLoading.value = true;

      await FloorService.addFloor(id, data);

      var list =
          (await FloorService.allBuildign(id)).cast<FloorResponseModel>();

      print(floorList.length);
      //buildingList.add(building!);
      isLoading.value = false;
      floorList.value = list;
      print(floorList.length);
    }
  }

  void deleteBuilding(String floorid, String buildingId) async {
    isLoading(true);
    bool isDeleted = await FloorService.deleteFloor(floorid, buildingId);

    if (isDeleted) {
      getFloor(buildingId);
    }
    isLoading(false);
  }

  //room
  void getRoom(String floorId) async {
    isLoading.value = true;
    print("hi room ");
    print("Flood ID:ROOM:$floorId");
    var list =
        (await RoomService.allRoombyFloor(floorId)).cast<RoomResponseModel>();

    print(roomList.length);
    //buildingList.add(building!);
    isLoading.value = false;
    roomList.value = list;
    print(roomList.length);
  }

  void addNewRoom(String id, RoomRequestModel data) async {
    if (isAlradyNameExistOnList(data, roomList)) {
      Get.snackbar("Ops", "This name alrady exist",
          colorText: whiteColor, backgroundColor: Colors.red);
    } else {
      isLoading.value = true;

      await RoomService.addRoom(id, data);

      var list =
          (await RoomService.allRoombyFloor(id)).cast<RoomResponseModel>();

      print(roomList.length);
      //buildingList.add(building!);
      isLoading.value = false;
      roomList.value = list;
      print(roomList.length);
    }
  }

  void deleteRoom(String floorid, String roomId) async {
    isLoading(true);
    bool isDeleted = await RoomService.deleteRoom(roomId, floorid);

    if (isDeleted) {
      getRoom(floorid);
    }
    isLoading(false);
  }

  void updateFloor(floorid, buildingId) async {
    isLoading(true);
    try {
      bool isEdited = await FloorService()
          .updateFloor(floorid, buildingId, updateEditingController.text);
      if (isEdited) {
        Get.back();
        Get.snackbar("Updated", "Successfully Updated",
            colorText: whiteColor, backgroundColor: Colors.green);
        getFloor(buildingId);
      }
    } on SocketException {
      Get.snackbar("Oh", "No Internet",
          colorText: whiteColor, backgroundColor: Colors.red);
    } catch (e) {
      print(e.toString());
    }

    isLoading(false);
  }

  void updateRoom(String floorid, String roomId) async {
    isLoading(true);
    try {
      bool isEdited = await RoomService()
          .updateRoom(roomId, floorid, updateEditingController.text);
      if (isEdited) {
        Get.back();
        Get.snackbar("Updated", "Successfully Updated",
            colorText: whiteColor, backgroundColor: Colors.green);
        getRoom(floorid);
      }
    } on SocketException {
      Get.snackbar("Oh", "No Internet",
          colorText: whiteColor, backgroundColor: Colors.red);
    } catch (e) {
      print(e.toString());
    }

    isLoading(false);
  }
  // void removeItem(ItemModel item) {
  //   floorList.remove(item);
  // }

  // void addRoomItem(ItemModel item) {
  //   roomList.add(item);
  // }

  // void removeRoomItem(ItemModel item) {
  //   roomList.remove(item);
  // }

  @override
  void onInit() {
    // print(
    //   "Floor ID:",
    // );
    getFloor(routeItemInfo.buildingId.toString());
    super.onInit();
  }
}
