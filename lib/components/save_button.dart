import 'package:flutter/material.dart';
import 'package:gridapp/components/amplitude/amplitude.dart';
import 'package:gridapp/provider/carousel_provider.dart';
import 'package:gridapp/provider/image_resize_provider.dart';
import 'package:gridapp/provider/pick_image_provider.dart';
import 'package:provider/provider.dart';

import '../provider/grid_provider.dart';
import '../provider/split_image_provider.dart';
import '../screens/export_screen.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    var imagePicker = context.watch<ImagePickerProvider>();
    var splitImageProvider = context.read<SplitImageProvider>();
    var imageResize = context.read<ImageResizeProvider>();
    var gridProvider = context.watch<GridProvider>();
    var carouselProvider = context.watch<CarouselProvider>();
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: 0,
          minimumSize: Size(
            MediaQuery.of(context).size.width * 0.85,
            MediaQuery.of(context).size.height * 0.07,
          ), // Size(width, height)
          backgroundColor:
              imagePicker.image != null ? Colors.white : Colors.grey,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
      child: Text(
        "Done",
        style: TextStyle(color: Colors.black),
      ),
      onPressed: () async {
        if (imagePicker.image != null) {
          if (gridProvider.grid_or_carousel) {
            await AmplitudeConnection.image_cropped(
                gridProvider.grid_or_carousel,
                gridProvider.grid_option_list[gridProvider.selectedRow - 2],
                null);
            await imageResize.capturePng();
            //final Uint8List list = await splitImageProvider.getLocalFile();
            //set list and row manuel
            splitImageProvider.imageList = splitImageProvider.splitImage(
                imageResize.file!, gridProvider.selectedRow);
          } else {
            await AmplitudeConnection.image_cropped(
                gridProvider.grid_or_carousel,
                null,
                carouselProvider
                    .carousel_option_list[carouselProvider.carouselSize - 2]);
            await imageResize.capturePng();
            //final Uint8List list = await splitImageProvider.getLocalFile();
            //set list and row manuel
            splitImageProvider.imageList =
                splitImageProvider.splitImageCarousel(
                    imageResize.file!, carouselProvider.carouselSize);
          }

          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ExportScreen()));
        }
      },
    );
  }
}



/*
Future<String> Save(Uint8List bytes) async {
  await [Permission.storage].request();
  final time = DateTime.now()
      .toIso8601String()
      .replaceAll(".", "-")
      .replaceAll(":", "-");
  final name = "screenshot$time";
  final res = await ImageGallerySaver.saveImage(bytes, name: name);
  return res["filepath"];
}
*/