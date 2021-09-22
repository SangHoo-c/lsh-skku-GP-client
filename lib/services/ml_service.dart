import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class MLService {
  Dio dio = Dio();

  // ml server
  Future<String> convertImageToText(Uint8List imageData) async {
    try {
      var encodedData = await compute(base64Encode, imageData);
      Response response = await dio.post(
          'http://localhost:5000/v1/image/convert_text',
          data: {'image': encodedData});
      print(response);
      return response.data;
    } catch (e) {
      print("i'm dead");
      return null;
    }
  }
}
