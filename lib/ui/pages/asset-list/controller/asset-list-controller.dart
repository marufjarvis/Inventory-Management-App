// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_mangament_app/ui/pages/add-building-asset/model/building-create-response.dart';
import 'package:inventory_mangament_app/ui/pages/add-building-asset/service/asset-service.dart';
import 'package:inventory_mangament_app/ui/pages/asset-details/service/asset-details-service.dart';
import 'package:inventory_mangament_app/ui/pages/asset-list/model/asset-details-response-model.dart';
import 'package:inventory_mangament_app/ui/pages/asset-list/model/asset-request-model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inventory_mangament_app/constatns/color.dart';
import 'package:inventory_mangament_app/ui/pages/asset-details/service/upload-image.dart';
import 'package:inventory_mangament_app/ui/pages/asset-details/view/asset-details-page.dart';
import 'package:inventory_mangament_app/ui/pages/asset-list/model/asset-model.dart';
import 'package:inventory_mangament_app/ui/pages/floor-room/model/floor-model.dart';

class AssetListController extends GetxController {
  var routeInfo = Get.arguments as FloorRouteMotel;
  var routeInfoCore = Get.arguments as FloorRouteMotel;
  var assetList = <AssetModel>[].obs;
  var assetDetailsList = <AssetDetailsResponseModel>[].obs;
  var suggetionList = <String>[].obs;
  var key = GlobalKey<AutoCompleteTextFieldState<String>>();
  var initialTextController = TextEditingController().obs;
  var remarkTextController = TextEditingController().obs;
  var assetTextController = TextEditingController().obs;
  var pickedFile = XFile("path").obs;
  var isAlreadyAddedAsset = false.obs;
  var isAssetLoading = false.obs;
  var isHide = true.obs;
  var assetListOnline = <BuildingCreateResponseModel>[].obs;

  var selectedDropdownVlau = "".obs;
  var selectedAssetId = "".obs;

  var isLoading = false.obs;
  Rx<Position>? currentPosition = const Position(
          longitude: 0,
          latitude: 0,
          timestamp: null,
          accuracy: 0,
          altitude: 0,
          heading: 0,
          speed: 0,
          speedAccuracy: 0)
      .obs;

  Future<void> getCurrentPosition() async {
    isAssetLoading(true);
    final hasPermission = await handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      currentPosition!.value = position;
      print(currentPosition!.value.latitude);
      print(currentPosition!.value.longitude);
    }).catchError((e) {
      debugPrint(e);
    });

    isAssetLoading(false);
  }

  bool changeDropdownValue(String val) {
    print("HI");
    //selectedDropdownVlaue.value = val;
    bool isFound = false;
    for (var element in assetListOnline) {
      if (element.name == val) {
        print("Selcted ID:${element.id}");
        selectedAssetId.value = element.id.toString();
        isFound = true;
        break;
      }
    }
    if (isFound == true) {
      return true;
    } else {
      Get.snackbar("Ops", "Not available in asset list",
          colorText: Colors.white, backgroundColor: Colors.red);
      return false;
    }
  }

  void getAssets() async {
    isAssetLoading.value = true;
    print("hi");
    var list =
        (await AssetService.allAsset()).cast<BuildingCreateResponseModel>();

    print(assetList.length);
    //buildingList.add(building!);
    isAssetLoading.value = false;
    assetListOnline.value = list;

    for (var element in assetListOnline) {
      suggetionList.add(element.name);
      // selectedDropdownVlaue.value = suggetionList[0];
      assetTextController.value.text = suggetionList[0];

      print(selectedAssetId.value);
    }
    print(assetList.length);
    selectedAssetId.value = assetListOnline[0].id.toString();
    assetTextController.value.text = assetListOnline[0].name.toLowerCase();
  }

  @override
  void onClose() {
    isAlreadyAddedAsset.value = false;
    isHide.value = true;
    super.onClose();
  }

  @override
  void onInit() {
    isHide.value = true;
    isAlreadyAddedAsset.value = false;
    print(routeInfo.roomNo);
    print("room ID:${routeInfo.roomId}");
    getAssets();
    getAssetDetailList(routeInfo.roomId.toString());
    super.onInit();
  }

  void getAssetDetailList(String roomId) async {
    isLoading.value = true;
    try {
      print("hi");
      var list = (await AssetDetailsService.allAssetDetails(roomId))
          .cast<AssetDetailsResponseModel>();

      print(assetDetailsList.length);
      //buildingList.add(building!);

      assetDetailsList.value = list;
    } catch (e) {}
    isLoading.value = false;
    print(assetDetailsList.length);
  }

  void addNewAssetDetails(
      String roomId, AssetRequestModel data, BuildContext context) async {
    isLoading.value = true;

    await AssetDetailsService.addAssetDetail(roomId, data);
    Get.snackbar("Added", "Successfully Added",
        colorText: whiteColor, backgroundColor: Colors.green);

    var list = (await AssetDetailsService.allAssetDetails(roomId))
        .cast<AssetDetailsResponseModel>();

    print(assetDetailsList.length);
    //buildingList.add(building!);
    isLoading.value = false;
    assetDetailsList.value = list;
    isAlreadyAddedAsset(true);

    Navigator.of(context).pop();
    initialTextController.value.clear();
    remarkTextController.value.clear();
    print(assetDetailsList.length);
  }

  void deleteBuilding(String roomId, String assetDetailsId) async {
    isLoading(true);
    bool isDeleted =
        await AssetDetailsService.deleteAssetDetail(roomId, assetDetailsId);

    if (isDeleted) {
      Get.snackbar("Deleted", "Successfully Deleted",
          colorText: whiteColor, backgroundColor: Colors.red);
      getAssetDetailList(roomId);
    }
    isLoading(false);
  }

  // void addAssetItem(AssetModel item) {
  //   assetList.add(item);
  // }

  Future<void> captureImage(BuildContext context) async {
    try {
      XFile? pickedFilefile = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
        maxWidth: 1920,
        maxHeight: 1920,
      );

      if (pickedFilefile != null) {
        pickedFile.value = pickedFilefile;
        var response = await UploadImageService().uploadImage(
          file: pickedFile.value,
        );

        print(response['message']);

        if (response != null &&
            response['message'] == "Image uploaded successfully!") {
          routeInfo.imageUrl = response['filename'];
          //routeInfo.assetName = selectedDropdownVlaue.value;
          routeInfo.assetName = assetTextController.value.text;

          Get.to(const AssetDetailsPage(), arguments: routeInfo);
        } else {
          Get.snackbar(
            "Ops",
            "Image not uploaded",
            colorText: whiteColor,
            backgroundColor: Colors.red,
          );
        }

        // ignore: use_build_context_synchronously
        // cropImage(
        //     await pickedFilefile.readAsBytes(), pickedFilefile.path, context);
      }
      print("success");
      print(pickedFilefile!.path);
    } catch (e) {
      print("Please try again");
      print(e.toString());
    }
  }

  // Future captureImage(BuildContext context) async {
  //   try {
  //     XFile? pickedFilefile = await ImagePicker().pickImage(
  //         source: ImageSource.camera,
  //         imageQuality: 50,
  //         maxWidth: 1920,
  //         maxHeight: 1920);

  //     if (pickedFilefile != null) {
  //       pickedFile.value = pickedFilefile;
  //       var response = await UploadImageService().uploadImage(
  //         file: pickedFile.value,
  //       );

  //       if (response['message'] == "Image uploaded successfully!") {
  //         routeInfo.imageUrl = response['filename'];
  //         routeInfo.assetName = assetTextEditigngController.value.text;
  //         assetTextEditigngController.clear();

  //         //Get.to(const AssetDetailsPage(), arguments: routeInfo);
  //       } else {
  //         Get.snackbar("Ops", "Image not uploaded",
  //             colorText: whiteColor, backgroundColor: Colors.red);
  //       }

  //       // ignore: use_build_context_synchronously
  //       // cropImage(
  //       //     await pickedFilefile.readAsBytes(), pickedFilefile.path, context);
  //     }
  //     print("success");
  //     print(pickedFilefile!.path);
  //   } catch (e) {
  //     print("Please Try again");
  //     print(e.toString());
  //   }
  // }

  Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar(
          "Ops", "Location services are disabled. Please enable the services",
          colorText: whiteColor, backgroundColor: Colors.red);

      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar("Ops", "Location permissions are denied",
            colorText: whiteColor, backgroundColor: Colors.red);
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Get.snackbar("Ops",
          "Location permissions are permanently denied, we cannot request permissions",
          colorText: whiteColor, backgroundColor: Colors.red);

      return false;
    }
    return true;
  }

  // cropImage(Uint8List byte, String path, BuildContext context) async {
  //   ImageCropping.cropImage(
  //       context: context,
  //       imageBytes: byte,
  //       onImageDoneListener: (data) {
  //         writeToFile(data, path);
  //       },
  //       customAspectRatios: [
  //         const CropAspectRatio(
  //           ratioX: 4,
  //           ratioY: 5,
  //         ),
  //       ],
  //       visibleOtherAspectRatios: true,
  //       squareBorderWidth: 2,
  //       isConstrain: false,
  //       squareCircleColor: primaryColor,
  //       defaultTextColor: whiteColor,
  //       selectedTextColor: blueColor,
  //       colorForWhiteSpace: whiteColor,
  //       makeDarkerOutside: true,
  //       outputImageFormat: OutputImageFormat.jpg,
  //       encodingQuality: 10);
  // }

  // Future<void> writeToFile(Uint8List data, String path) async {
  //   pickedFile = await File(path).writeAsBytes(data).whenComplete(
  //       () => Get.to(const AssetDetailsPage(), arguments: routeInfo));
  // }
}
