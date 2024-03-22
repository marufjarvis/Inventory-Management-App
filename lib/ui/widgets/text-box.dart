// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:inventory_mangament_app/constatns/color.dart';
import 'package:inventory_mangament_app/constatns/pm.dart';

class CustomTextBox extends StatelessWidget {
  const CustomTextBox(
      {super.key,
      required this.hint,
      required this.controller,
      this.isNotCirle,
      this.line,
      this.type,
      this.isPassword});
  final String hint;
  final TextEditingController controller;
  final bool? isNotCirle;
  final int? line;
  final TextInputType? type;
  final bool? isPassword;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPassword ?? false,
      maxLines: line ?? 1,
      minLines: line ?? 1,
      keyboardType: type ?? TextInputType.name,
      controller: controller,
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
          fontSize: pm17, fontWeight: FontWeight.w400, color: blackColor),
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(8),
          hintStyle: Theme.of(context)
              .textTheme
              .displaySmall!
              .copyWith(fontSize: pm17, fontWeight: FontWeight.w400),
          hintText: hint,
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: isNotCirle == false
                  ? BorderRadius.circular(pm22)
                  : BorderRadius.circular(5)),
          filled: true,
          fillColor: whiteColor),
    );
  }
}
