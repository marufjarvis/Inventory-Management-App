import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:inventory_mangament_app/constatns/api.dart';
import 'package:image_picker/image_picker.dart';

class UploadImageService {
  Future uploadImage({
    required XFile file,
    //required Map<String, String> data,
  }) async {
    String url = "${globalUrl}images/upload";
    final uri = Uri.parse(url);
    try {
      http.MultipartRequest request = http.MultipartRequest("POST", uri);
      http.MultipartFile multipartFile =
          await http.MultipartFile.fromPath('file', file.path);
      request.files.add(multipartFile);
      request.headers.addAll(_header());
      // request.fields.addAll(data);
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      print(jsonDecode(response.body));
      print("done");
      return jsonDecode(response.body);
    } catch (e) {
      print("error");
      return null;
    }
  }

  _header() {
    return {"Content-Type": "multipart/form-data"};
  }
}
