// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:flutter/material.dart';

import '../../../../constatns/api.dart';

const String downloadUrl = "${globalUrl}admin/export/projects/1";

class ExportDataServcie {
  static Future<bool> exportData() async {
    //var response;
    // String url = "${globalUrl}admin/export/projects/1";

    // Map<String, String> headers = {
    //   'Content-Type': 'application/json',
    //   "data": "habib"
    // };

    try {} on SocketException {
      debugPrint("No Internet Connection");
    } catch (e) {
      debugPrint(e.toString());
    }

    return true;
  }
}
