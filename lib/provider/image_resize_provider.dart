import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';

class ImageResizeProvider extends ChangeNotifier {
  GlobalKey globalKey = GlobalKey();
  Uint8List? file;
  //screenshot widget
  Future<void> capturePng() async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage();
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      //final directory = (await getExternalStorageDirectory())!.path;
      //print((await getExternalStorageDirectory())!.path);
      //String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      //File imgFile = new File('$directory/$fileName.png');

      //print("$directory / $fileName.png");
      //imgFile.writeAsBytes(pngBytes);
      file = pngBytes;
      //print('Image Saved Successfully');
    } catch (e) {
      print(e);
    }
  }
}
