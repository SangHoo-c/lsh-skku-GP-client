import 'dart:typed_data';

import '../services/file_picker_service.dart';
import '../services/ml_service.dart';
import 'package:flutter/material.dart';

class ImagePage extends StatefulWidget {
  @override
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  MLService _mlService = MLService();
  FilePickerService _filePickerService = FilePickerService();

  Uint8List defaultImage;
  String license_plate = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('license plate'),
        actions: [
          IconButton(
            icon: Icon(Icons.image),
            onPressed: selectImage,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            LoadingImage(defaultImage),
            Icon(
              Icons.keyboard_arrow_down,
              size: 50,
            ),
            Text(
              license_plate,
              style: TextStyle(
                fontSize: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget LoadingImage(Uint8List imageData) {
    if (imageData == null) {
      return Center(
        child: Container(
          child: Text(
            'No Image',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
      );
    } else if (imageData.length == 0) {
      return Center(
        child: Column(
          children: [
            CircularProgressIndicator(),
            SizedBox(
              height: 5,
            ),
            Text('Loading'),
          ],
        ),
      );
    } else {
      return Image.memory(
        imageData,
        fit: BoxFit.fitWidth,
      );
    }
  }

  void selectImage() async {
    setState(() {
      defaultImage = Uint8List(0);
      license_plate = "";
    });

    var imageData = await _filePickerService.imageFilePickAsBytes();

    if (imageData != null) {
      setState(() {
        defaultImage = imageData;
      });

      license_plate = await _mlService.convertImageToText(imageData);
      print(license_plate);

      setState(() {
        if (license_plate == "") {
          license_plate = "";
        } else {
          license_plate = license_plate;
        }
      });
    } else {
      setState(() {
        defaultImage = null;
        license_plate = "";
      });
    }
  }
}
