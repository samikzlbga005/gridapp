import 'package:flutter/material.dart';
import 'package:gridapp/components/carousel/custom_carousel_paint.dart';
import 'package:gridapp/provider/carousel_provider.dart';
import 'package:gridapp/provider/pick_image_provider.dart';
import 'package:provider/provider.dart';

import '../../provider/image_resize_provider.dart';
import '../../provider/split_image_provider.dart';
import '../amplitude/amplitude.dart';

class CarouselViewTemplate extends StatelessWidget {
  const CarouselViewTemplate({super.key});

  @override
  Widget build(BuildContext context) {
    var imagePickerProvider = context.watch<ImagePickerProvider>();
    var carouselProvider = context.watch<CarouselProvider>();
    var splitImage = context.watch<SplitImageProvider>();
    var imageResizeProvider = context.watch<ImageResizeProvider>();
    return GestureDetector(
      onTap: () async {
        await AmplitudeConnection.add_image_tapped();
        if (imagePickerProvider.image == null) {
          await imagePickerProvider.pickImage(context, null);
          if (imagePickerProvider.image != null) {
            splitImage.filePath = imagePickerProvider.image!.path;
          }
        }
      },
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            imagePickerProvider.image != null
                ? RepaintBoundary(
                    key: imageResizeProvider.globalKey,
                    child: InteractiveViewer(
                      constrained: true,
                      boundaryMargin: EdgeInsets.all(50),
                      minScale: 0.5,
                      maxScale: 4.0,
                      panEnabled: true,
                      scaleEnabled: true,
                      child: Image.file(
                        imagePickerProvider.image!,
                        height: carouselProvider.heightPicture,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                  )
                : Image.asset(
                    carouselProvider.carouselImagePic,
                    height: MediaQuery.of(context).size.height * 0.5,
                  ),
            imagePickerProvider.image != null
                ? IgnorePointer(
                    child: Container(
                      height: carouselProvider.heightPicture,
                      child: CustomCarouselPaintWidget(
                          columns: carouselProvider.carouselSize),
                    ),
                  )
                : Text(
                    "Tap to add\nyour image",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
          ],
        ),
      ),
    );
  }
}
