import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';

class GridProvider extends ChangeNotifier {
  List<String> imageList = [
    "assets/gridButtons/2x3.png",
    "assets/gridButtons/3x3.png",
    "assets/gridButtons/4x3.png",
    "assets/gridButtons/5x3.png",
    "assets/gridButtons/6x3.png",
    "assets/gridButtons/7x3.png",
  ];
  List<String> imagesLigth = [
    "assets/gridButtons/2x3_ligth.png",
    "assets/gridButtons/3x3_ligth.png",
    "assets/gridButtons/4x3_ligth.png",
    "assets/gridButtons/5x3_ligth.png",
    "assets/gridButtons/6x3_ligth.png",
    "assets/gridButtons/7x3_ligth.png",
  ];
  List<String> showImageList = [
    "assets/gridButtons/2x3_ligth.png",
    "assets/gridButtons/3x3.png",
    "assets/gridButtons/4x3.png",
    "assets/gridButtons/5x3.png",
    "assets/gridButtons/6x3.png",
    "assets/gridButtons/7x3.png",
  ];

  List<String> gridTemplateList = [
    "assets/gridTemplate/2x3_gridTemplate.png",
    "assets/gridTemplate/3x3_gridTemplate.png",
    "assets/gridTemplate/4x3_gridTemplate.png",
    "assets/gridTemplate/5x3_gridTemplate.png",
    "assets/gridTemplate/6x3_gridTemplate.png",
    "assets/gridTemplate/7x3_gridTemplate.png",
  ];
  List<String> carouselList = [
    "assets/carouselButtons/1x2_carousel.png",
    "assets/carouselButtons/1x3_carousel.png",
    "assets/carouselButtons/1x4_carousel.png",
    "assets/carouselButtons/1x5_carousel.png",
    "assets/carouselButtons/1x6_carousel.png",
    "assets/carouselButtons/1x7_carousel.png",
  ];

  List<String> grid_option_list = ["2x3", "3x3", "4x3", "5x3", "6x3", "7x3"];

  bool isContinue = false;

  bool grid_or_carousel = false;
  bool isSSelected = false;
  int lastIndex = 0;
  double heigth = 0.0;
  double width = 0.0;
  String gridTemplateViewPic = "assets/gridTemplate/2x3_gridTemplate.png";

  bool gridOrCover = false;
  List<double> gridAspectRatioList = [
    0.6666666667,
    1,
    1.333333333,
    1.666666667,
    2,
    2.333333333,
  ];
  double gridHeight = 0; // max height
  double gridWidth = 0; // hesaplanacak
  int selectedColumn = 3; // default column
  double gridRatio = 2;
  int selectedRow = 2;

  void selectGrid(int index) {
    selectedRow = index + 2; //
    gridRatio = gridAspectRatioList[index];
    calculateGridDimensions();
  }

  void calculateGridDimensions() {
    gridWidth = (gridHeight / selectedRow) * selectedColumn;
    notifyListeners();
  }

  void openGridPage(int index) {
    gridTemplateViewPic = gridTemplateList[index];
    showImageList[lastIndex] = imageList[lastIndex];
    showImageList[index] = imagesLigth[index];
    lastIndex = index;
  }

  void GridCarousel(bool val) {
    grid_or_carousel = val;
    //print(grid_or_carousel);
  }

  Future<void> changeButton(int index) async {
    showImageList[lastIndex] = imageList[lastIndex];
    showImageList[index] = imagesLigth[index];
    lastIndex = index;
    gridTemplateViewPic = gridTemplateList[index];
    notifyListeners();
  }

  List<double> getImageSize(File image_path) {
    Image image = Image.file(image_path);
    Completer<Image> completer = Completer<Image>();
    double heigth_picture = 0.0;
    double width_picture = 0.0;
    List<double> imageSizes = [];
    image.image.resolve(ImageConfiguration()).addListener(
      ImageStreamListener((ImageInfo info, bool synchronousCall) {
        completer.complete(image);
        heigth_picture = info.image.height.toDouble();
        width_picture = info.image.width.toDouble();
      }),
    );
    imageSizes.add(heigth_picture);
    imageSizes.add(width_picture);
    return imageSizes;
  }

  Future<void> sizee(File? image) async {
    heigth = await getImageSize(image!)[0];
    width = await getImageSize(image)[1];
  }
}
