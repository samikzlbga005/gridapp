///parçalama fonksiyonu

import 'package:flutter/material.dart';
import 'package:gridapp/provider/carousel_provider.dart';
import 'package:gridapp/provider/grid_provider.dart';
import 'package:gridapp/provider/split_image_provider.dart';
import 'package:provider/provider.dart';

class ImageSplitter extends StatefulWidget {
  const ImageSplitter({super.key});

  @override
  State<ImageSplitter> createState() => _ImageSplitterState();
}

class _ImageSplitterState extends State<ImageSplitter> {
  List<Image> imageList = [];
  @override
  Widget build(BuildContext context) {
    var splitImageProvider = context.read<SplitImageProvider>();
    var gridProvider = context.watch<GridProvider>();
    var carouselProvider = context.watch<CarouselProvider>();
    List<double> val = [0.4, 0.5, 0.5, 0.7, 0.7, 0.7, 0.7, 0.7];
    print(gridProvider.selectedRow);
    return Padding(
      padding: gridProvider.grid_or_carousel
          ? gridProvider.selectedRow == 7
              ? const EdgeInsets.only(top: 20, left: 100, right: 100)
              : gridProvider.selectedRow > 4
                  ? const EdgeInsets.only(top: 20, left: 80, right: 80)
                  : const EdgeInsets.only(top: 40, left: 0, right: 0)
          : const EdgeInsets.only(top: 200, left: 0, right: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          gridProvider.grid_or_carousel
              ? Container(
                  height: gridProvider.selectedRow > 4
                      ? MediaQuery.of(context).size.height *
                          val[gridProvider.selectedRow]
                      : MediaQuery.of(context).size.height *
                          val[gridProvider.selectedRow],
                  child: GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 2,
                    children: List.generate(
                      splitImageProvider.imageList.length,
                      (index) => Container(
                          // width: MediaQuery.of(context).size.width * 0.5,
                          child: splitImageProvider.imageList[index]),
                    ),
                  ),
                )
              : Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: GridView.count(
                    crossAxisCount: carouselProvider.carouselSize,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 2,
                    children: List.generate(
                        splitImageProvider.imageList.length,
                        (index) => Container(
                            child: splitImageProvider.imageList[index])),
                  ),
                ),
        ],
      ),
    );
  }
}
