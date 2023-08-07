import 'package:flutter/material.dart';
import 'package:gridapp/components/amplitude/amplitude.dart';

class CarouselProvider extends ChangeNotifier {
  List<String> carouselTemplateList = [
    "assets/carouselTemplate/1x2.png",
    "assets/carouselTemplate/1x3.png",
    "assets/carouselTemplate/1x4.png",
    "assets/carouselTemplate/1x5.png",
    "assets/carouselTemplate/1x6.png",
    "assets/carouselTemplate/1x7.png",
  ];

  int carouselSize = 2;
  bool maxFinalSize = false;
  bool minFinalSize = false;

  String carouselImagePic = "assets/carouselTemplate/1x2.png";

  double heightPicture = 0;
  List<String> carousel_option_list = [
    "1x2",
    "1x3",
    "1x4",
    "1x5",
    "1x6",
    "1x7"
  ];

  Future<void> calculateHeight(double size) async {
    heightPicture = size / carouselSize;
    //print(heightPicture);
  }

  void openCarouselPage(int index, double size) async {
    carouselImagePic = carouselTemplateList[index];
    carouselSize = index + 2;
    notDisplayCarouselButton();
    AmplitudeConnection.carousel_option_selected(carousel_option_list[index]);
    await calculateHeight(size);
  }

  void notDisplayCarouselButton() {
    if (carouselSize == 7) {
      maxFinalSize = true;
    } else {
      maxFinalSize = false;
    }
    if (carouselSize == 2) {
      minFinalSize = true;
    } else {
      minFinalSize = false;
    }
  }

  void plusCarouselTemplate() {
    if (carouselSize == 7) {
      maxFinalSize = true;
      carouselImagePic = carouselTemplateList[carouselSize - 2];
    }
    if (!maxFinalSize) {
      carouselSize++;
      //print(carouselSize);
      carouselImagePic = carouselTemplateList[carouselSize - 2];
      minFinalSize = false;
    }
    notDisplayCarouselButton();
    notifyListeners();
  }

  void minusCarouselSize() {
    if (carouselSize == 2) {
      minFinalSize = true;
      carouselImagePic = carouselTemplateList[carouselSize - 2];
    }
    if (!minFinalSize) {
      carouselSize--;
      //print(carouselSize);
      carouselImagePic = carouselTemplateList[carouselSize - 2];
      maxFinalSize = false;
    }
    notDisplayCarouselButton();
    notifyListeners();
  }

  notifyListeners();
}
