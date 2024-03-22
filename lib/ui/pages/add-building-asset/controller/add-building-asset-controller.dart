// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_mangament_app/constatns/color.dart';
import 'package:inventory_mangament_app/ui/pages/add-building-asset/model/building-create-response.dart';
import 'package:inventory_mangament_app/ui/pages/add-building-asset/model/building-model.dart';
import 'package:inventory_mangament_app/ui/pages/add-building-asset/service/asset-service.dart';
import 'package:inventory_mangament_app/ui/pages/add-building-asset/service/building-service.dart';

class AddBuildingAssetController extends GetxController {
  dynamic routeItemInfo = Get.arguments;

  var buildingList = <BuildingCreateResponseModel>[].obs;
  var assetList = <BuildingCreateResponseModel>[].obs;
  TextEditingController textEditingController = TextEditingController();
  TextEditingController updateEditingController = TextEditingController();
  var isLoading = false.obs;
  BuildingCreateResponseModel? building;

  @override
  void onInit() {
    if (routeItemInfo["isBuilding"] == true) {
      getBuilding();
    } else {
      getAssets();
    }

    super.onInit();
  }

  void getBuilding() async {
    isLoading.value = true;
    print("hi");
    print(routeItemInfo["thanaId"]);
    var list =
        (await BuildingService.allBuildign(routeItemInfo["thanaId"], false))
            .cast<BuildingCreateResponseModel>();

    print(buildingList.length);
    //buildingList.add(building!);
    isLoading.value = false;
    buildingList.value = list;
    print(buildingList.length);
  }

  void addNewBuilding(String id, BuildingModel data) async {
    if (isAlradyNameExistOnList(data, buildingList) == true) {
      Get.snackbar("Ops", "Already Exist",
          colorText: whiteColor, backgroundColor: Colors.red);
    } else {
      isLoading.value = true;

      await BuildingService.addBuilding(id, data);

      var list = (await BuildingService.allBuildign(id, false))
          .cast<BuildingCreateResponseModel>();

      print(buildingList.length);
      //buildingList.add(building!);
      isLoading.value = false;
      buildingList.value = list;
      Get.snackbar("Added", "Successfully Added",
          colorText: whiteColor, backgroundColor: Colors.green);
      print(buildingList.length);
    }
  }

  void deleteBuilding(String thanaId, String buildingId) async {
    isLoading(true);
    bool isDeleted = await BuildingService.deleteBuilding(thanaId, buildingId);

    if (isDeleted) {
      getBuilding();

      Get.snackbar("Deleted", "Successfully Deleted",
          colorText: whiteColor, backgroundColor: Colors.green);
    }
    isLoading(false);
  }

  //assets
  void getAssets() async {
    isLoading.value = true;
    print("hi");
    var list =
        (await AssetService.allAsset()).cast<BuildingCreateResponseModel>();

    print(assetList.length);
    //buildingList.add(building!);
    isLoading.value = false;
    assetList.value = list;
    print(assetList.length);
  }

  void addNewAsset(BuildingModel data) async {
    if (isAlradyNameExistOnList(data, assetList) == true) {
      Get.snackbar("Ops", "Already Exist",
          colorText: whiteColor, backgroundColor: Colors.red);
    } else {
      isLoading.value = true;

      await AssetService.addAsset(data);

      var list =
          (await AssetService.allAsset()).cast<BuildingCreateResponseModel>();

      print(assetList.length);
      //buildingList.add(building!);
      isLoading.value = false;

      Get.snackbar("Added", "Successfully Added",
          colorText: whiteColor, backgroundColor: Colors.green);
      assetList.value = list;
      print(assetList.length);
    }
  }

  void deleteAsset(String assetId) async {
    isLoading(true);
    bool isDeleted = await AssetService.deleteAsset(assetId);

    if (isDeleted) {
      Get.snackbar("Deleted", "Successfully Deleted",
          colorText: whiteColor, backgroundColor: Colors.green);
      getAssets();
    }
    isLoading(false);
  }

  void updateAsset(String name, String assetId) async {
    isLoading(true);
    try {
      bool isEdited = await AssetService().updateAsset(name, assetId);
      if (isEdited) {
        Get.back();
        Get.snackbar("Updated", "Successfully Updated",
            colorText: whiteColor, backgroundColor: Colors.green);
        getAssets();
      }
    } on SocketException {
      Get.snackbar("Oh", "No Internet",
          colorText: whiteColor, backgroundColor: Colors.red);
    } catch (e) {
      print(e.toString());
    }

    isLoading(false);
  }

  bool isAlradyNameExistOnList(dynamic d, List<dynamic> list) {
    for (var item in list) {
      if (item.name.toLowerCase() == d.name.toLowerCase()) {
        return true;
      }
    }
    return false;
  }

  void updateBuilding(String thanaId, String buildingId, String value) async {
    isLoading(true);
    try {
      bool isEdited =
          await BuildingService().updateBuilding(thanaId, buildingId, value);
      if (isEdited) {
        Get.back();
        Get.snackbar("Updated", "Successfully Updated",
            colorText: whiteColor, backgroundColor: Colors.green);
        getBuilding();
      }
    } on SocketException {
      Get.snackbar("Oh", "No Internet",
          colorText: whiteColor, backgroundColor: Colors.red);
    } catch (e) {
      print(e.toString());
    }

    isLoading(false);
  }

  // void addItem(ItemModel item) {
  //   if (routeItemInfo["isBuilding"] == true) {
  //     //buildingList.add(item);
  //   } else {
  //     assetList.add(item);
  //   }
  // }

  // void removeItem(ItemModel item) {
  //   if (routeItemInfo["isBuilding"] == true) {
  //     buildingList.remove(item);
  //   } else {
  //     assetList.remove(item);
  //   }
  // }
}
