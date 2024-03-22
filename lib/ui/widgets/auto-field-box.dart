// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:inventory_mangament_app/ui/pages/asset-list/controller/asset-list-controller.dart';
import '../../constatns/color.dart';
import '../../constatns/pm.dart';
import '../pages/home/controller/home-controller.dart';

class SuggetionBox extends StatelessWidget {
  const SuggetionBox({
    super.key,
    required this.homeController,
    required this.hint,
    required this.textEditingController,
    required this.list,
  });

  final HomeController homeController;
  final String hint;
  final TextEditingController textEditingController;
  final List<String> list;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SimpleAutoCompleteTextField(
          key: GlobalKey(),
          style: Theme.of(context)
              .textTheme
              .displaySmall!
              .copyWith(fontWeight: FontWeight.normal, fontSize: pm20),
          decoration: InputDecoration(
              isDense: false,
              fillColor: whiteColor,
              filled: true,
              hintText: hint,
              hintStyle: Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(fontWeight: FontWeight.normal, fontSize: pm18),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(defoultPM),
              )),
          controller: textEditingController,
          suggestions: list,
          clearOnSubmit: false,
          textSubmitted: (text) => hint == "District"
              ? homeController.districtController.value.text = text
              : homeController.thanaController.value.text = text);
    });
  }
}

class SuggetionBoxAsset extends StatelessWidget {
  const SuggetionBoxAsset({
    super.key,
    required this.assetListController,
    required this.hint,
    required this.textEditingController,
    required this.list,
  });

  final AssetListController assetListController;
  final String hint;
  final TextEditingController textEditingController;
  final List<String> list;

  @override
  Widget build(BuildContext context) {
    return SimpleAutoCompleteTextField(
        key: GlobalKey(),
        style: Theme.of(context)
            .textTheme
            .displaySmall!
            .copyWith(fontWeight: FontWeight.normal, fontSize: pm20),
        decoration: InputDecoration(
            isDense: false,
            fillColor: whiteColor,
            filled: true,
            hintText: hint,
            hintStyle: Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(fontWeight: FontWeight.normal, fontSize: pm18),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(defoultPM),
            )),
        controller: textEditingController,
        suggestions: list,
        clearOnSubmit: false,
        textSubmitted: (text) =>
            assetListController.assetTextController.value.text = text);
  }
}
