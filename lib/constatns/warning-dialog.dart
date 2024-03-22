import 'package:flutter/material.dart';
import 'package:inventory_mangament_app/ui/widgets/custom-button.dart';

Future<dynamic> warningDialog(BuildContext context, GestureTapCallback tap) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
          content: Text(
            "Are you sure?",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Colors.black),
          ),
          title: Text(
            "Warning",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Colors.red),
          ),
          actions: [
            CustomButton(
                title: "No",
                tap: () {
                  Navigator.of(context).pop();
                }),
            CustomButton(title: "Yes", tap: tap),
          ],
        );
      });
}
