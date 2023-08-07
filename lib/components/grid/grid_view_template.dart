import 'package:amplitude_flutter/amplitude.dart';
import 'package:flutter/material.dart';
import 'package:gridapp/components/amplitude/amplitude.dart';
import 'package:gridapp/components/grid/custom_paint.dart';
import 'package:gridapp/provider/grid_provider.dart';
import 'package:gridapp/provider/image_resize_provider.dart';
import 'package:gridapp/provider/pick_image_provider.dart';
import 'package:gridapp/provider/split_image_provider.dart';
import 'package:provider/provider.dart';

import '../../provider/image_resize_provider.dart';
import '../../provider/image_resize_provider.dart';

class GridViewTemplate extends StatefulWidget {
  const GridViewTemplate({super.key});

  @override
  State<GridViewTemplate> createState() => _GridViewTemplateState();
}

class _GridViewTemplateState extends State<GridViewTemplate> {
  @override
  Widget build(BuildContext context) {
    var imagePickerProvider = context.watch<ImagePickerProvider>();
    var gridProvider = context.watch<GridProvider>();
    var splitImage = context.watch<SplitImageProvider>();
    var imageResizeProvider = context.watch<ImageResizeProvider>();
    int selectedRows = gridProvider.selectedRow;
    print(gridProvider.gridWidth * gridProvider.gridRatio);
    print(gridProvider.gridWidth);

    return GestureDetector(
      onTap: () async {
        await AmplitudeConnection.add_image_tapped();
        //eger resim secilmeden geri donerse ikinci if
        if (imagePickerProvider.image == null) {
          await imagePickerProvider.pickImage(context, null);
          if (imagePickerProvider.image != null) {
            splitImage.filePath = imagePickerProvider.image!.path;
          }
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          imagePickerProvider.image != null
              ? RepaintBoundary(
                  key: imageResizeProvider.globalKey,
                  child: InteractiveViewer(
                    constrained: true,
                    boundaryMargin: EdgeInsets.all(50),
                    minScale: 0.1,
                    maxScale: 6.0,
                    panEnabled: true,
                    scaleEnabled: true,
                    child: Image.file(
                      imagePickerProvider.image!,
                      height: gridProvider.gridWidth * gridProvider.gridRatio,
                      width: gridProvider.gridWidth,
                    ),
                  ))
              : Image.asset(
                  gridProvider.gridTemplateViewPic,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                ),
          imagePickerProvider.image != null
              ? IgnorePointer(
                  child: Container(
                    height: gridProvider.gridHeight,
                    width: gridProvider.gridWidth, // hesaplanan genişlik
                    child: CustomPaintWidget(rows: selectedRows),
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
    );
  }
}





/*
Stack(
        children: [
          Container(
            child: GridView.count(
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              children: List.generate(6, (index) {
                return Container(
                  color: Color.fromRGBO(255, 255, 255, 0.279),
                  margin: EdgeInsets.all(1.0),
                  child: Center(
                    child: Text(
                      '',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          InteractiveViewer(
            constrained: true,
            boundaryMargin: EdgeInsets.all(50),
            minScale: 1,
            maxScale: 4.0,
            panEnabled: false,
            scaleEnabled: true,
            child: Container(
              child: Image.asset(
                'assets/asd.jpeg',
                fit: BoxFit.contain,
                opacity: AlwaysStoppedAnimation(.7),
                height: MediaQuery.of(context).size.height * 0.45,
              ),
            ),
          ),
        ],
      ),

 */