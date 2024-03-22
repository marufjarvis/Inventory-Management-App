// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:inventory_mangament_app/constatns/string.dart';
import 'package:inventory_mangament_app/route.dart';
import 'package:inventory_mangament_app/ui/themes/theme.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(MyApp(
    prefs: prefs,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.prefs});
  final SharedPreferences prefs;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print(prefs.getString(email));
    print(prefs.getString(token));
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      initialRoute: prefs.getString(token) == null ? loginRoute : homeRoute,
      getPages: AppRoutes.route(),
      theme: AppTheme.appTheme,
    );
  }
}
