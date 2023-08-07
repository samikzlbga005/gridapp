import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:gridapp/provider/rate_us_provider.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../components/amplitude/amplitude.dart';
import 'carousel_provider.dart';
import 'grid_provider.dart';

Future<void> saveImageToGallery(
    List<Uint8List> imageList, BuildContext context) async {
  var gridProvider = context.read<GridProvider>();
  var carouselProvider = context.read<CarouselProvider>();
  var rate_us_provider = context.read<RateUsProvider>();

  print(imageList.length);
  int k = imageList.length + 1;
  for (var i = 0; i < imageList.length; i++) {
    k--;
    final directory = (await getExternalStorageDirectory())!.path;
    print((await getExternalStorageDirectory())!.path);
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    //File imgFile = new File('$directory/${fileName}_$i.png');
    await ImageGallerySaver.saveImage(imageList[k - 1],
        name: "$directory/${fileName}_${k - 1}");
    //print("$directory/${fileName}_${k - 1}.png");
    //imgFile.writeAsBytes(imageList[k - 1]);
  }

  await AmplitudeConnection.cropped_images_saved(
      gridProvider.grid_or_carousel,
      gridProvider.grid_option_list[gridProvider.selectedRow - 2],
      carouselProvider.carousel_option_list[carouselProvider.carouselSize - 2]);
  await rate_us_provider.increamentImageSavedFlow();
}
