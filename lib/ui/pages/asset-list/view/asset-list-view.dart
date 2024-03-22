// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_mangament_app/constatns/string.dart';
import 'package:inventory_mangament_app/constatns/warning-dialog.dart';
import 'package:inventory_mangament_app/ui/pages/asset-list/controller/asset-list-controller.dart';
import 'package:inventory_mangament_app/ui/pages/asset-list/model/asset-details-response-model.dart';
import '../../../../constatns/color.dart';
import '../../../../constatns/pm.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';

class AssetListView extends StatelessWidget {
  const AssetListView({super.key});

  @override
  Widget build(BuildContext context) {
    final AssetListController assetListController =
        Get.put(AssetListController());
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            assetList,
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
        body: Stack(
          children: [
            Container(
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
                    child: Column(
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
                      height: pm15,
                    ),
                    AssetList(assetListController: assetListController),
                    Addnew(controller: assetListController),
                  ],
                ))),
            Obx(() {
              return assetListController.isHide.value == false
                  ? Container(
                      margin: const EdgeInsets.only(top: 100),
                      color: primaryColor,
                      alignment: Alignment.topCenter,
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Select Asset"),
                              IconButton(
                                  onPressed: () {
                                    assetListController.isHide.value = true;
                                  },
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.red,
                                  ))
                            ],
                          ),
                          const SizedBox(
                            height: 13,
                          ),
                          Obx(() {
                            return SimpleAutoCompleteTextField(
                                //  minLength: 2,
                                key: const GlobalObjectKey(1),
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                        fontWeight: FontWeight.normal,
                                        fontSize: pm15),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(defoultPM),
                                  ),
                                  //isDense: true,
                                  fillColor: whiteColor,
                                  filled: true,
                                  hintText: "Asset Name",
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(
                                          fontWeight: FontWeight.normal,
                                          fontSize: pm18),
                                ),
                                controller: assetListController
                                    .assetTextController.value,
                                suggestions: assetListController.suggetionList,
                                clearOnSubmit: false,
                                textSubmitted: (text) {
                                  assetListController
                                      .assetTextController.value.text = text;
                                  assetListController.changeDropdownValue(text);
                                  assetListController.isHide.value = true;
                                });
                          }),
                        ],
                      ),
                    )
                  : Container();
            })
          ],
        ));
  }
}

class AssetList extends StatelessWidget {
  const AssetList({
    super.key,
    required this.assetListController,
  });

  final AssetListController assetListController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(() => assetListController.isLoading.value == false
          ? assetListController.assetDetailsList.isNotEmpty
              ? ListView.builder(
                  itemCount: assetListController.assetDetailsList.length,
                  itemBuilder: (context, index) {
                    AssetDetailsResponseModel item =
                        assetListController.assetDetailsList[index];
                    return AssetDetailsItem(item: item);
                  })
              : const Center(
                  child: Text("Not have any item"),
                )
          : const Center(
              child: CircularProgressIndicator(),
            )),
    );
  }
}

class AssetDetailsItem extends StatelessWidget {
  const AssetDetailsItem({
    super.key,
    required this.item,
  });

  final AssetDetailsResponseModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: pm15),
      decoration: BoxDecoration(
          color: whiteColor, borderRadius: BorderRadius.circular(pm10)),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(pm10),
              child: Image.network(
                  fit: BoxFit.cover, height: pm90, width: pm90, item.imageUrl),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.initialTag.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(fontSize: 16),
                  ),
                  Text(
                    "${item.building},${item.floor},${item.room}",
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(fontSize: 13),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                  Wrap(
                    children: [
                      Text(
                        "Lon:${item.gpsLongitude}\nLat:${item.gpsLatitude}",
                        style:
                            Theme.of(context).textTheme.displaySmall!.copyWith(
                                  fontSize: 12,
                                ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      )
                    ],
                  ),
                  Text(
                    "${item.district},${item.thana}",
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(fontSize: 12, color: blackColor),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                            color: blueColor,
                            borderRadius: BorderRadius.circular(25)),
                        child: Text(
                          item.date.toString().split(" ").first,
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(fontSize: 12, color: whiteColor),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      IconButton(
                          splashRadius: 10,
                          onPressed: () {
                            final controller = Get.put(AssetListController());

                            warningDialog(context, () {
                              controller.deleteBuilding(
                                  controller.routeInfo.roomId.toString(),
                                  item.id.toString());
                              Navigator.of(context).pop();
                            });
                          },
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                            size: 20,
                          ))
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Addnew extends StatelessWidget {
  const Addnew({
    super.key,
    required this.controller,
  });

  final AssetListController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: pm24,
        top: pm10,
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: whiteColor, borderRadius: BorderRadius.circular(pm10)),
        padding: const EdgeInsets.symmetric(horizontal: pm20, vertical: pm15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              createAsset,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(fontSize: pm15),
            ),
            const SizedBox(
              height: defoultPM,
            ),
            Row(
              children: [
                Expanded(
                  child: Obx(() {
                    return controller.isAssetLoading.value
                        ? Center(
                            child: CircularProgressIndicator(
                              color: blackColor,
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              controller.isHide.value = false;
                            },
                            child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border:
                                      Border.all(width: 1, color: blackColor)),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  controller.assetTextController.value.text,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          );
                  }
                      //  DropdownButtonHideUnderline(
                      //     child: DropdownButton<String>(
                      //       value:
                      //           controller.selectedDropdownVlaue.value,
                      //       //hint: const Text('Select Asset'),
                      //       onChanged: (newValue) {
                      //         controller.changeDropdownValue(newValue!);
                      //       },
                      //       items: controller.suggetionList
                      //           .map<DropdownMenuItem<String>>(
                      //               (String value) {
                      //         return DropdownMenuItem<String>(
                      //           value: value,
                      //           child: Text(
                      //             value,
                      //             style: const TextStyle(fontSize: 16),
                      //           ),
                      //         );
                      //       }).toList(),
                      //     ),
                      //   );

                      ),
                ),
                const SizedBox(
                  width: pm10,
                ),
                CircleAvatar(
                  backgroundColor: blueColor,
                  child: IconButton(
                      onPressed: () async {
                        if (await controller.handleLocationPermission() ==
                            false) {
                          Get.snackbar("Ops", "Please on your location",
                              colorText: whiteColor,
                              backgroundColor: Colors.red);
                        } else {
                          if (controller.suggetionList.isNotEmpty &&
                              controller
                                  .assetTextController.value.text.isNotEmpty) {
                            if (controller.changeDropdownValue(
                                controller.assetTextController.value.text)) {
                              controller.getCurrentPosition().whenComplete(() {
                                if (controller.isAssetLoading.value == false) {
                                  // Get.snackbar("Hey", "Go",
                                  //     colorText: whiteColor,
                                  //     backgroundColor: Colors.green);
                                  controller.captureImage(context);
                                } else {
                                  Get.snackbar("Ops", "Please wait...",
                                      colorText: whiteColor,
                                      backgroundColor: Colors.red);
                                }
                                controller.captureImage(context);
                              });
                            }
                          } else {
                            Get.snackbar("Ops", "Asset name cannot be empty",
                                backgroundColor: Colors.red,
                                colorText: whiteColor);
                          }
                        }

                        // controller.addAssetItem(
                        // AssetModel(
                        //     assetName:
                        //         controller.assetTextEditigngController.text,
                        //     buildingName: controller.routeInfo.building,
                        //     thane: controller.routeInfo.thane,
                        //     district: controller.routeInfo.district,
                        //     roomNo: controller.routeInfo.roomNo,
                        //     floorNo: controller.routeInfo.floorNo,
                        //     gpsLocation: "Dhaka,Bangladesh",
                        //     createDT: DateTime(2023).toString())
                        // );
                      },
                      icon: Icon(
                        Icons.camera_alt,
                        color: whiteColor,
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
