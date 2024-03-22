// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:inventory_mangament_app/constatns/color.dart';

import '../../constatns/pm.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.title,
      required this.tap,
      this.isDefault = true,
      this.needBgColorChnage,
      this.isLoadingButton});
  final String title;
  final GestureTapCallback tap;
  final bool? isDefault;
  final bool? needBgColorChnage;
  final bool? isLoadingButton;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: isDefault == true
                    ? BorderRadius.circular(pm24)
                    : BorderRadius.circular(pm10))),
            minimumSize: const MaterialStatePropertyAll(Size(pm80, pm40)),
            backgroundColor: needBgColorChnage == true
                ? MaterialStatePropertyAll(whiteColor)
                : MaterialStatePropertyAll(blueColor)),
        onPressed: isLoadingButton == true ? null : tap,
        child: isLoadingButton == true
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircularProgressIndicator(
                  color: whiteColor,
                ),
              )
            : Text(
                title,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: needBgColorChnage == true ? blackColor : whiteColor,
                    fontSize: pm18),
              ));
  }
}
