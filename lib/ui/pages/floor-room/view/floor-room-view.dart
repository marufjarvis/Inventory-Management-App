import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_mangament_app/constatns/warning-dialog.dart';
import 'package:inventory_mangament_app/ui/pages/floor-room/controller/floor-room-controller.dart';
import 'package:inventory_mangament_app/ui/pages/floor-room/model/floor-model.dart';
import 'package:inventory_mangament_app/ui/pages/floor-room/model/floor-request-model.dart';
import 'package:inventory_mangament_app/ui/pages/floor-room/model/floor-response-model.dart';
import 'package:inventory_mangament_app/ui/pages/floor-room/model/room-request-model.dart';
import 'package:inventory_mangament_app/ui/pages/floor-room/model/room-response-model.dart';
import '../../../../constatns/color.dart';
import '../../../../constatns/pm.dart';
import '../../../../constatns/string.dart';

class FloorRoomVew extends StatelessWidget {
  const FloorRoomVew({super.key, required this.floorRouteMotel});
  final FloorRouteMotel floorRouteMotel;

  @override
  Widget build(BuildContext context) {
    final FloorRoomController controller = Get.put(FloorRoomController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          floorList,
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      body: Container(
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
                  "${floorRouteMotel.district}> ${floorRouteMotel.thane}> ${floorRouteMotel.building}",
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(fontSize: pm15),
                ),
              ),
              const SizedBox(
                height: pm18,
              ),
              Expanded(
                  child: ItemList(
                controller: controller,
                itemList: controller.floorList,
              )),
              Addnew(controller: controller)
            ],
          ),
        ),
      ),
    );
  }
}

class Addnew extends StatelessWidget {
  const Addnew({
    super.key,
    required this.controller,
  });

  final FloorRoomController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: pm24, top: pm10),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: whiteColor, borderRadius: BorderRadius.circular(pm10)),
        padding: const EdgeInsets.symmetric(horizontal: pm20, vertical: pm15),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller.textEditingController,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(fontSize: pm17),
                decoration: InputDecoration(
                    hintStyle: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(fontSize: pm15),
                    hintText: "Floor No"),
              ),
            ),
            TextButton(
                onPressed: () {
                  // Random random = Random();p

                  // controller.addItem(ItemModel(
                  //     title: controller.textEditingController.text,
                  //     district: controller.routeItemInfo.district!,
                  //     thana: controller.routeItemInfo.thane!,
                  //     id: random.nextInt(10000)));
                  if (controller.textEditingController.value.text.isEmpty) {
                    Get.snackbar(
                      "Ops",
                      "Filed cannot be empty",
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  } else {
                    controller.addNewFloor(
                        controller.routeItemInfo.buildingId.toString(),
                        FloorRequestModel(
                            name: controller.textEditingController.text,
                            active: true,
                            buildingId: 63));
                  }
                  controller.textEditingController.clear();
                },
                child: Text(
                  save,
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(fontSize: pm15),
                ))
          ],
        ),
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  const ItemList({
    super.key,
    required this.itemList,
    required this.controller,
  });
  final List<FloorResponseModel> itemList;
  final FloorRoomController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.isLoading.value == false
          ? itemList.isNotEmpty
              ? ListView.builder(
                  itemCount: itemList.length,
                  itemBuilder: (context, index) {
                    FloorResponseModel item = itemList[index];
                    return ItemWidget(item: item, controller: controller);
                  },
                )
              : const Align(
                  alignment: Alignment.center,
                  child: Text("Not have Any Item"),
                )
          : const Center(
              child: CircularProgressIndicator(),
            );
    });
  }
}

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    super.key,
    required this.item,
    required this.controller,
  });

  final FloorResponseModel item;
  final FloorRoomController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: pm15, vertical: defoultPM),
      margin: const EdgeInsets.only(bottom: pm10),
      decoration: BoxDecoration(
          color: whiteColor,
          border: Border.all(width: 1, color: blueColor),
          borderRadius: BorderRadius.circular(defoultPM)),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                controller.routeItemInfo.floorNo = item.name;
                controller.routeItemInfo.floorId = item.id.toString();
                controller.floorID.value = item.id.toString();
                print(controller.floorID.value);
                //get floor id
                controller.getRoom(item.id.toString());
                Get.to(const RoomView(),
                    arguments: controller.routeItemInfo,
                    transition: Transition.rightToLeftWithFade);
              },
              child: Text(
                "Floor ${item.name}",
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(fontSize: pm17, fontWeight: FontWeight.normal),
              ),
            ),
          ),
          const SizedBox(
            width: pm12,
          ),
          CircleAvatar(
              radius: pm17,
              backgroundColor: blueColor,
              child: IconButton(
                  onPressed: () {
                    controller.routeItemInfo.floorNo = item.name;
                    controller.routeItemInfo.floorId = item.id.toString();
                    controller.floorID.value = item.id.toString();
                    controller.getRoom(item.id.toString());
                    Get.to(const RoomView(),
                        arguments: controller.routeItemInfo,
                        transition: Transition.rightToLeftWithFade);
                  },
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: whiteColor,
                    size: pm20,
                  ))),
          const SizedBox(
            width: pm12,
          ),
          CircleAvatar(
              radius: pm17,
              backgroundColor: Colors.red,
              child: IconButton(
                  onPressed: () {
                    // controller.removeItem(item);
                    controller.updateEditingController.text = item.name;

                    showDialog(
                        context: context,
                        builder: (builder) {
                          return AlertDialog(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            content: Padding(
                              padding: const EdgeInsets.only(
                                  bottom: pm24, top: pm10),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: whiteColor,
                                    borderRadius: BorderRadius.circular(pm10)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: pm20, vertical: pm15),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller:
                                            controller.updateEditingController,
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall!
                                            .copyWith(fontSize: pm17),
                                        decoration: InputDecoration(
                                          hintStyle: Theme.of(context)
                                              .textTheme
                                              .displaySmall!
                                              .copyWith(fontSize: pm15),
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          //test - create new building
                                          if (controller.updateEditingController
                                              .value.text.isEmpty) {
                                            Get.snackbar(
                                              "Ops",
                                              "Filed cannot be empty",
                                              backgroundColor: Colors.red,
                                              colorText: Colors.white,
                                            );
                                          } else {
                                            controller.updateFloor(
                                                item.id.toString(),
                                                item.buildingId.toString());
                                          }

                                          controller.updateEditingController
                                              .clear();
                                        },
                                        child: Text(
                                          save,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayLarge!
                                              .copyWith(fontSize: pm15),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  },
                  icon: Icon(
                    Icons.edit,
                    color: whiteColor,
                    size: pm20,
                  ))),
          const SizedBox(
            width: pm12,
          ),
          CircleAvatar(
              radius: pm17,
              backgroundColor: Colors.red,
              child: IconButton(
                  onPressed: () {
                    warningDialog(context, () {
                      controller.deleteBuilding(
                          item.id.toString(), item.buildingId.toString());
                      Navigator.of(context).pop();
                    });
                  },
                  icon: Icon(
                    Icons.delete_outline,
                    color: whiteColor,
                    size: pm20,
                  )))
        ],
      ),
    );
  }
}

//for room - view
class RoomView extends StatefulWidget {
  const RoomView({super.key});

  @override
  State<RoomView> createState() => _RoomViewState();
}

class _RoomViewState extends State<RoomView> {
  final FloorRoomController controller = Get.put(FloorRoomController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          roomeList,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        //     child: SizedBox(
        //         width: 80, child: CustomButton(title: "Manu", tap: () {})),
        //   )
        // ],
      ),
      body: Container(
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
                  "${controller.routeItemInfo.district}> ${controller.routeItemInfo.thane}> ${controller.routeItemInfo.building}> ${controller.routeItemInfo.floorNo}",
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(fontSize: pm15),
                ),
              ),
              const SizedBox(
                height: pm18,
              ),
              Expanded(
                  child: ItemRoomList(
                controller: controller,
                itemList: controller.roomList,
              )),
              AddRoomnew(controller: controller)
            ],
          ),
        ),
      ),
    );
  }
}

class ItemRoomWidget extends StatelessWidget {
  const ItemRoomWidget({
    super.key,
    required this.item,
    required this.controller,
  });

  final RoomResponseModel item;
  final FloorRoomController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: pm15, vertical: defoultPM),
      margin: const EdgeInsets.only(bottom: pm10),
      decoration: BoxDecoration(
          color: whiteColor,
          border: Border.all(width: 1, color: blueColor),
          borderRadius: BorderRadius.circular(defoultPM)),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                controller.routeItemInfo.roomNo = item.name;
                controller.routeItemInfo.roomId = item.id.toString();
                Get.toNamed(
                  assetLIstRoute,
                  arguments: controller.routeItemInfo,
                );
              },
              child: Text(
                "Room ${item.name}",
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(fontSize: pm17, fontWeight: FontWeight.normal),
              ),
            ),
          ),
          const SizedBox(
            width: pm12,
          ),
          CircleAvatar(
              radius: pm17,
              backgroundColor: blueColor,
              child: IconButton(
                  onPressed: () {
                    controller.routeItemInfo.roomNo = item.name;
                    controller.routeItemInfo.roomId = item.id.toString();
                    Get.toNamed(
                      assetLIstRoute,
                      arguments: controller.routeItemInfo,
                    );
                  },
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: whiteColor,
                    size: pm20,
                  ))),
          const SizedBox(
            width: pm12,
          ),
          CircleAvatar(
              radius: pm17,
              backgroundColor: Colors.red,
              child: IconButton(
                  onPressed: () {
                    // controller.removeItem(item);
                    controller.updateEditingController.text = item.name;

                    showDialog(
                        context: context,
                        builder: (builder) {
                          return AlertDialog(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            content: Padding(
                              padding: const EdgeInsets.only(
                                  bottom: pm24, top: pm10),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: whiteColor,
                                    borderRadius: BorderRadius.circular(pm10)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: pm20, vertical: pm15),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller:
                                            controller.updateEditingController,
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall!
                                            .copyWith(fontSize: pm17),
                                        decoration: InputDecoration(
                                          hintStyle: Theme.of(context)
                                              .textTheme
                                              .displaySmall!
                                              .copyWith(fontSize: pm15),
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          //test - create new building
                                          if (controller.updateEditingController
                                              .value.text.isEmpty) {
                                            Get.snackbar(
                                              "Ops",
                                              "Filed cannot be empty",
                                              backgroundColor: Colors.red,
                                              colorText: Colors.white,
                                            );
                                          } else {
                                            controller.updateRoom(
                                                item.floorId.toString(),
                                                item.id.toString());
                                          }

                                          controller.updateEditingController
                                              .clear();
                                        },
                                        child: Text(
                                          save,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayLarge!
                                              .copyWith(fontSize: pm15),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  },
                  icon: Icon(
                    Icons.edit,
                    color: whiteColor,
                    size: pm20,
                  ))),
          const SizedBox(
            width: pm12,
          ),
          CircleAvatar(
              radius: pm17,
              backgroundColor: Colors.red,
              child: IconButton(
                  onPressed: () {
                    warningDialog(context, () {
                      controller.deleteRoom(
                          item.floorId.toString(), item.id.toString());
                      Navigator.of(context).pop();
                    });
                  },
                  icon: Icon(
                    Icons.delete_outline,
                    color: whiteColor,
                    size: pm20,
                  )))
        ],
      ),
    );
  }
}

class AddRoomnew extends StatelessWidget {
  const AddRoomnew({
    super.key,
    required this.controller,
  });

  final FloorRoomController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: pm24, top: pm10),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: whiteColor, borderRadius: BorderRadius.circular(pm10)),
        padding: const EdgeInsets.symmetric(horizontal: pm20, vertical: pm15),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller.textEditingController,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(fontSize: pm17),
                decoration: InputDecoration(
                    hintStyle: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(fontSize: pm15),
                    hintText: "Room No"),
              ),
            ),
            TextButton(
                onPressed: () {
                  if (controller.textEditingController.value.text.isNotEmpty) {
                    controller.addNewRoom(
                        controller.floorID.value,
                        RoomRequestModel(
                            name: controller.textEditingController.text,
                            active: true,
                            floorId: 10));

                    controller.textEditingController.clear();
                  } else {
                    Get.snackbar("Ops", "Room no cannot be empty",
                        colorText: whiteColor, backgroundColor: Colors.red);
                  }
                },
                child: Text(
                  save,
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(fontSize: pm15),
                ))
          ],
        ),
      ),
    );
  }
}

class ItemRoomList extends StatelessWidget {
  const ItemRoomList({
    super.key,
    required this.itemList,
    required this.controller,
  });
  final List<RoomResponseModel> itemList;
  final FloorRoomController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return itemList.isNotEmpty
          ? ListView.builder(
              itemCount: itemList.length,
              itemBuilder: (context, index) {
                RoomResponseModel item = itemList[index];
                return ItemRoomWidget(item: item, controller: controller);
              },
            )
          : const Align(
              alignment: Alignment.center,
              child: Text("Not have Any Item"),
            );
    });
  }
}
