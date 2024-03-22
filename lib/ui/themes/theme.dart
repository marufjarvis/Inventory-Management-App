// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:inventory_mangament_app/constatns/color.dart';
import 'package:inventory_mangament_app/constatns/pm.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData appTheme = ThemeData(
      useMaterial3: true,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: whiteColor,
      //primarySwatch: MaterialColor(0, primaryColor as Map<int, Color>),
      buttonTheme: ButtonThemeData(
        buttonColor: blueColor,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(pm24)),
      ),
      textTheme: TextTheme(
        titleSmall: GoogleFonts.openSans(
            fontSize: pm22, fontWeight: FontWeight.normal, color: blackColor),
        titleMedium: GoogleFonts.openSans(
            fontSize: pm26, fontWeight: FontWeight.w600, color: blackColor),
        titleLarge: GoogleFonts.openSans(
            fontSize: pm30, fontWeight: FontWeight.bold, color: blackColor),
        displaySmall: GoogleFonts.openSans(
            fontSize: pm22, fontWeight: FontWeight.normal, color: blackColor),
        displayMedium: GoogleFonts.openSans(
            fontSize: pm26, fontWeight: FontWeight.w600, color: blackColor),
        displayLarge: GoogleFonts.openSans(
            fontSize: pm30, fontWeight: FontWeight.bold, color: blackColor),
      ));
}
