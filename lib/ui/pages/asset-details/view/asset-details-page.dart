import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_mangament_app/constatns/color.dart';
import 'package:inventory_mangament_app/constatns/pm.dart';
import 'package:inventory_mangament_app/constatns/string.dart';
import 'package:inventory_mangament_app/ui/pages/asset-list/controller/asset-list-controller.dart';
import 'package:inventory_mangament_app/ui/pages/asset-list/model/asset-request-model.dart';
import 'package:inventory_mangament_app/ui/pages/floor-room/model/floor-model.dart';
import 'package:inventory_mangament_app/ui/widgets/custom-button.dart';
import 'package:inventory_mangament_app/ui/widgets/text-box.dart';

class AssetDetailsPage extends StatelessWidget {
  const AssetDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AssetListController assetListController =
        Get.put(AssetListController());

    assetListController.isAlreadyAddedAsset.value = false;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          setAssetDetail,
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/bgimg.png'),
                fit: BoxFit.cover)),
        child: SafeArea(
          child: ListView(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${assetListController.routeInfo.district}> ${assetListController.routeInfo.thane}> ${assetListController.routeInfo.building}> ${assetListController.routeInfo.floorNo}> ${assetListController.routeInfo.roomNo}",
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(fontSize: pm15),
                ),
              ),
              const SizedBox(
                height: pm20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(pm15),
                      color: whiteColor),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(pm15),
                      child: Image.file(
                        File(assetListController.pickedFile.value.path),
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: pm20,
              ),
              CustomTextBox(
                hint: initialTagno,
                type: TextInputType.number,
                controller: assetListController.initialTextController.value,
                isNotCirle: true,
              ),
              const SizedBox(
                height: pm10,
              ),
              CustomTextBox(
                line: 3,
                hint: remarkNote,
                controller: assetListController.remarkTextController.value,
                isNotCirle: true,
              ),
              const SizedBox(
                height: pm10,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Obx(() {
                  return assetListController.isLoading.value == false
                      ? CustomButton(
                          title: save,
                          tap: () {
                            if (assetListController
                                .initialTextController.value.text.isEmpty) {
                              Get.snackbar(
                                  'Empty', "Initial tag no cannot be emmpty",
                                  colorText: whiteColor,
                                  backgroundColor: Colors.red);
                            } else if (assetListController
                                .remarkTextController.value.text.isEmpty) {
                              Get.snackbar('Empty', "Remarks cannot be emmpty",
                                  colorText: whiteColor,
                                  backgroundColor: Colors.red);
                            } else {
                              FloorRouteMotel assetInfo =
                                  assetListController.routeInfo;
                              assetListController.addNewAssetDetails(
                                  //room id
                                  assetInfo.roomId.toString(),
                                  AssetRequestModel(
                                      name: assetInfo.assetName!,
                                      gpsLatitude: assetListController
                                          .currentPosition!.value.latitude
                                          .toString(),
                                      gpsLongitude: assetListController
                                          .currentPosition!.value.longitude
                                          .toString(),
                                      date: DateTime.now(),
                                      imageUrl: assetInfo.imageUrl!,
                                      initialTag: assetListController
                                          .initialTextController.value.text,
                                      remarks: assetListController
                                          .remarkTextController.value.text,
                                      asset: Asset(
                                          id: int.parse(assetListController
                                              .selectedAssetId.value))),
                                  context);
                            }
                          })
                      : CustomButton(
                          tap: () {},
                          title: save,
                          isLoadingButton: true,
                        );
                }),
              ),
              const SizedBox(
                height: 30,
              ),
              Obx(() {
                return Visibility(
                  visible: assetListController.isAlreadyAddedAsset.value,
                  child: AnimatedContainer(
                    padding: const EdgeInsets.symmetric(
                        horizontal: pm30, vertical: pm20),
                    margin: const EdgeInsets.only(bottom: pm20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(pm20)),
                    duration: const Duration(seconds: 2),
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: CustomButton(
                            needBgColorChnage: true,
                            title: addNewAsset,
                            tap: () {
                              Navigator.of(context).pop();
                            },
                            isDefault: false,
                          ),
                        ),
                        // const SizedBox(
                        //   height: pm10,
                        // ),
                        // SizedBox(
                        //   width: double.infinity,
                        //   child: CustomButton(
                        //     needBgColorChnage: true,
                        //     title: showAssetList,
                        //     tap: () {},
                        //     isDefault: false,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
