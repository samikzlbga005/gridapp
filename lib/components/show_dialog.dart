import 'package:amplitude_flutter/amplitude.dart';
import 'package:flutter/material.dart';
import 'package:gridapp/provider/rate_us_provider.dart';
import 'package:provider/provider.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';

import '../provider/ad_settings_provider.dart';
import '../provider/carousel_provider.dart';
import '../provider/cover_pack_provider.dart';
import '../provider/download_image_list.dart';
import '../provider/grid_provider.dart';
import '../provider/pick_image_provider.dart';
import '../provider/split_image_provider.dart';
import '../screens/all_special_highlights.dart';
import '../screens/did_you_like.dart';
import 'ads/unity_ads.dart';
import 'amplitude/amplitude.dart';
import 'image_saved_dialog.dart';

Future<void> ShowPopUp(BuildContext context, String text, String? button1Text,
    String? button2Text, bool? GridOrHgihLights, List<dynamic>? coversList) {
  var splitImageProvider = context.read<SplitImageProvider>();
  var gridProvider = context.read<GridProvider>();
  var carouselProvider = context.read<CarouselProvider>();
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      var coverProvider = context.watch<PacksProvider>();
      var adSettingsProvider = context.watch<AdSettingsProvider>();
      var rateUsProvider = context.read<RateUsProvider>();

      return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 19, 20, 22),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          content: Padding(
            padding: const EdgeInsets.only(top: 0, left: 0, right: 0),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          actions: [
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    minimumSize: Size(
                      MediaQuery.of(context).size.width * 0.35,
                      MediaQuery.of(context).size.height * 0.065,
                    ), // Size(width, height)
                    backgroundColor: const Color.fromARGB(255, 38, 38, 38),
                  ),
                  child: Text(
                    button1Text == null
                        ? "Discard Images"
                        : button1Text, //cancel,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onPressed: () async {
                    if (button1Text == null) {
                      await AmplitudeConnection.cropped_images_discarded(
                          gridProvider.grid_or_carousel,
                          gridProvider
                              .grid_option_list[gridProvider.selectedRow - 2],
                          carouselProvider.carousel_option_list[
                              carouselProvider.carouselSize - 2]);
                      context.read<ImagePickerProvider>().deleteImage();
                      Navigator.pop(context);
                      Navigator.pop(context);
                    } else {
                      if (gridProvider.gridOrCover) {
                        //grid or carousel
                        await AmplitudeConnection.video_ad_popup_closed(
                            gridProvider.grid_or_carousel, null);
                        gridProvider.gridOrCover = false;
                        gridProvider.isContinue = false;
                      } else {
                        //single or all download
                        print("null");
                        await AmplitudeConnection.video_ad_popup_closed(
                            null, true);
                      }
                      Navigator.pop(context);
                      print("aynı sayfada kaldı");
                    }
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    minimumSize: Size(
                      MediaQuery.of(context).size.width * 0.35,
                      MediaQuery.of(context).size.height * 0.065,
                    ), // Size(width, height)
                    backgroundColor: const Color.fromARGB(255, 38, 38, 38),
                  ),
                  child: Text(
                    button2Text == null
                        ? "Cancel"
                        : button2Text, //buttontext2 = "continue"
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onPressed: () async {
                    if (button2Text == null) {
                      await AmplitudeConnection.discard_popup_closed();
                      Navigator.pop(context);
                    } else {
                      if (gridProvider.gridOrCover) {
                        await AmplitudeConnection.watch_ad_tapped(
                          gridProvider.grid_or_carousel,
                          null,
                          null,
                          null,
                          null,
                          null,
                          carouselProvider.carousel_option_list[
                              carouselProvider.carouselSize - 2],
                          gridProvider
                              .grid_option_list[gridProvider.selectedRow - 2],
                        );
                      } else {
                        //single cover downsload -> second parameter = true
                        await AmplitudeConnection.watch_ad_tapped(
                          null,
                          true,
                          coversList![0].toString(), //packname
                          coversList[1], //packorder
                          coversList[2], //covername
                          coversList[3], //coverorder
                          carouselProvider.carousel_option_list[
                              carouselProvider.carouselSize - 2],
                          gridProvider
                              .grid_option_list[gridProvider.selectedRow - 2],
                        );
                      }
                      //if this statemet is false -> Grid Or Carousel
                      //grid ya da carousel ise burası çalışır
                      if (GridOrHgihLights == false) {
                        gridProvider.isContinue = true;
                        Navigator.pop(context);
                      }
                      //sinlge cover ise burası çalışır
                      else {
                        coverProvider.isContinue = true;
                        print("single cover calisti");
                        adSettingsProvider
                            .reset_number_of_highlights_download();
                        await AdManager.ShowVideoAdCover(context, [
                          coversList![0].toString(),
                          coversList[1],
                          coversList[2],
                          coversList[3]
                        ]);
                        saveHighLightsImageToGallery(
                            coverProvider
                                .all_images_cover[
                                    adSettingsProvider.index_highlight]
                                .highlightImage
                                .toString(),
                            [
                              coversList[0].toString(),
                              coversList[1],
                              coversList[2],
                              coversList[3]
                            ],
                            context);
                      }
                    }
                  },
                ),
              ],
            ),
          ]);
    },
  );
}
