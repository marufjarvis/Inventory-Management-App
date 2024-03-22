// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_mangament_app/constatns/string.dart';
import 'package:inventory_mangament_app/ui/pages/add-building-asset/model/building-create-response.dart';
import 'package:inventory_mangament_app/ui/pages/add-building-asset/service/building-service.dart';
import 'package:inventory_mangament_app/ui/pages/home/model/district-model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:inventory_mangament_app/ui/pages/home/model/thana-model.dart';
import 'package:inventory_mangament_app/ui/pages/home/service/district-service.dart';
import 'package:inventory_mangament_app/ui/pages/home/service/thana-service.dart';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';

class HomeController extends GetxController {
  var districtController = TextEditingController().obs;
  var thanaController = TextEditingController().obs;
  var buildingController = TextEditingController().obs;
  var isThanaSelected = false.obs;
  var isBuilding = false.obs;
  var isBuildingLoading = false.obs;

  GlobalKey<AutoCompleteTextFieldState<String>> key1 = GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<String>> key2 = GlobalKey();
  var selectedDistrictId = "none".obs;
  var selectedThanaId = "none".obs;
  var selectedBuildingId = "none".obs;

  // var districtModelList =
  //     districtModelsFromJson(jsonEncode(districtListJson)).obs;
  // var thanaModelList = thanaListsFromJson(jsonEncode(thanaListJson)).obs;
  // var buildingModelList =
  //     buildingModelFromJson(jsonEncode(buildingListJson)).obs;

  var suggetionDistrict = <String>[].obs;
  var suggetionThana = <String>[].obs;
  var suggetionBuilding = <String>[].obs;

  var districtListAdmin = <DistrictModelNew>[].obs;
  var thanaListAdmin = <ThanaModelNew>[].obs;
  var thanaListUser = <DistrictModelNew>[].obs;
  //var buildingModelList = <BuildingModel>[].obs;
  var suggetionBuildingOnline = <BuildingCreateResponseModel>[].obs;
  var isLoading = false.obs;
  late SharedPreferences sharedPreferences;

  void readydistrictSuggetionList() {
    for (var i = 0; i < districtListAdmin.length; i++) {
      suggetionDistrict.add(districtListAdmin[i].name!.toString());
    }
  }

  void readythanaSuggetionList(String selectedId) async {
    print(selectedId);
    if (sharedPreferences.getString(userType) != "admin") {
      var thanas = await ThanaService.getAllThanaUser(districtId: selectedId);

      if (thanas.isNotEmpty) {
        thanaListUser.value = thanas;
      }
    }
    suggetionThana.value = [];

    if (sharedPreferences.getString(userType) != "admin") {
      for (var i = 0; i < thanaListUser.length; i++) {
        suggetionThana.add(thanaListUser[i].name.toString());
      }
    } else {
      for (var i = 0; i < thanaListAdmin.length; i++) {
        if (thanaListAdmin[i].districtId.toString() == selectedId) {
          suggetionThana.add(thanaListAdmin[i].name.toString());
        }
      }
    }
  }

  void readyBuildingSuggetionList(String selectedId) async {
    isBuildingLoading(true);
    print("ID:Okay");
    print(selectedId);
    suggetionBuilding.value = [];
    //var list = buildingModelFromJson(jsonEncode(buildingListJson));

    var list = await BuildingService.allBuildign(selectedId, true);

    if (list.isNotEmpty) {
      suggetionBuildingOnline.value = list;
      for (var i = 0; i < list.length; i++) {
        suggetionBuilding.add(list[i].name.toString());
      }
    }

    //  for (var i = 0; i < list.length; i++) {
    //   if (list[i].id == selectedId) {
    //     suggetionBuilding.add(list[i].name.toString());
    //   }
    // }

    // if (list.isNotEmpty) {
    //   suggetionBuilding.value = list;
    // }

    isBuildingLoading(false);
  }

  void getDistriceAndThana() async {
    isLoading(true);

    if (sharedPreferences.getString(userType) == "admin") {
      var districts = await DistrictService.getAllDistrict();
      var thanas = await ThanaService.getAllThana();
      if (districts.isNotEmpty && thanas.isNotEmpty) {
        districtListAdmin.value = districts;
        thanaListAdmin.value = thanas;

        print(thanaListAdmin[0].name);
      }
    } else {
      var districts = await DistrictService.getAllDistrictUser();

      if (districts.isNotEmpty) {
        districtListAdmin.value = districts;
      }
    }

    print(districtListAdmin[0].name);

    readydistrictSuggetionList();

    isLoading(false);
  }

  void initOffline() async {
    sharedPreferences = await SharedPreferences.getInstance();
    getDistriceAndThana();
  }

  @override
  void onInit() {
    initOffline();

    super.onInit();
  }
}
