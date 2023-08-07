import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'dart:ui' as ui;

class SplitImageProvider extends ChangeNotifier {
  String? filePath;
  List<Image> imageList = [];
  List<Uint8List> encodedImages = [];
  List<Image> splitImage(Uint8List input, int row) {
    encodedImages.clear();
    // convert image to image from image package
    img.Image? image = img.decodeImage(input);

    int x = 0, y = 0;
    int width = (image!.width / 3).round();
    // split image to parts
    List<img.Image> parts = [];
    for (int i = 0; i < row; i++) {
      for (int j = 0; j < 3; j++) {
        parts.add(
          img.copyCrop(image, x: x, y: y, width: width, height: width),
        );
        x += width;
      }
      x = 0;
      y += width;
    }

    //convert image for save gallery(encode Image to Uint8list)
    convertImage(parts);

    // convert image from image package to Image Widget to display
    List<Image> _imageList = [];
    for (var singlePart in parts) {
      _imageList.add(Image.memory(img.encodePng(singlePart) as Uint8List));
    }
    imageList = _imageList;
    return imageList;
  }

  void convertImage(List<img.Image> parts) {
    for (var part in parts) {
      // Encode the image as PNG
      List<int> encodedPart = img.encodePng(part);

      // Alternatively, encode the image as JPEG with a specific quality (80 in this example)
      // List<int> encodedPart = img.encodeJpg(part, quality: 80);

      Uint8List uint8list = Uint8List.fromList(encodedPart);

      encodedImages.add(uint8list);
    }
  }

  List<Image> splitImageCarousel(Uint8List input, int column) {
    encodedImages.clear();
    // convert image to image from image package
    img.Image? image = img.decodeImage(input);

    int x = 0, y = 0;
    int width = (image!.width / column).round();
    // split image to parts
    List<img.Image> parts = [];
    for (int j = 0; j < column; j++) {
      parts.add(
        img.copyCrop(image, x: x, y: y, width: width, height: width),
      );
      x += width;
    }

    convertImage(parts);

    // convert image from image package to Image Widget to display
    List<Image> _imageList = [];
    for (var singlePart in parts) {
      _imageList.add(Image.memory(img.encodePng(singlePart) as Uint8List));
    }
    imageList = _imageList;

    return imageList;
  }

  Future<Uint8List> getLocalFile() async {
    return File('$filePath').readAsBytes();
  }
}
