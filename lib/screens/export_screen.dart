import 'package:flutter/material.dart';
import 'package:gridapp/components/ads/unity_ads.dart';
import 'package:gridapp/components/split_image.dart';
import 'package:gridapp/constants/constants.dart';
import 'package:gridapp/provider/ad_settings_provider.dart';
import 'package:gridapp/provider/grid_provider.dart';
import 'package:gridapp/provider/rate_us_provider.dart';
import 'package:provider/provider.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';

import '../components/amplitude/amplitude.dart';
import '../components/image_saved_dialog.dart';
import '../components/show_dialog.dart';
import '../provider/carousel_provider.dart';
import '../provider/download_image_list.dart';
import '../provider/pick_image_provider.dart';
import '../provider/split_image_provider.dart';
import 'package:image/image.dart' as img;

import 'did_you_like.dart';

class ExportScreen extends StatefulWidget {
  const ExportScreen({super.key});

  @override
  State<ExportScreen> createState() => _ExportScreenState();
}

class _ExportScreenState extends State<ExportScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await AdManager.loadUnityAd();
    });
  }

  @override
  Widget build(BuildContext context) {
    var splitImageProvider = context.read<SplitImageProvider>();
    var adSettingProvider = context.watch<AdSettingsProvider>();
    var gridProvider = context.watch<GridProvider>();
    var carouselProvider = context.watch<CarouselProvider>();
    var rate_us_provider = context.read<RateUsProvider>();
    var adSettingsProvider = context.watch<AdSettingsProvider>();
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text(
          "Export",
          style: TextStyle(fontSize: 24),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () async {
            await AmplitudeConnection.back_icon_tapped();
            ShowPopUp(
                context,
                "You did not save the images to your gallery. If you return edit screen, you will be lost images.",
                null,
                null,
                null,
                null);
          },
        ),
      ),
      body: Scaffold(
        backgroundColor: backgroundColor,
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    child: ImageSplitter(),
                  ),
                ],
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      minimumSize: Size(
                        MediaQuery.of(context).size.width * 0.85,
                        MediaQuery.of(context).size.height * 0.07,
                      ),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                  child: Text(
                    "Save to your gallery",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () async {
                    gridProvider.gridOrCover = true; //grid
                    if (context
                        .read<AdSettingsProvider>()
                        .showAddGridStatement()) {
                      await ShowPopUp(
                          context,
                          "You need to watch a video ad to save images to your gallery",
                          "Cancel",
                          "Continue",
                          false,
                          null);
                      if (gridProvider.isContinue) {
                        await AmplitudeConnection.save_images_button_tapped(
                            gridProvider.grid_or_carousel,
                            gridProvider
                                .grid_option_list[gridProvider.selectedRow - 2],
                            carouselProvider.carousel_option_list[
                                carouselProvider.carouselSize - 2]);

                        await AdManager.ShowVideoAd(context, [
                          gridProvider.grid_or_carousel,
                          gridProvider
                              .grid_option_list[gridProvider.selectedRow - 2],
                          carouselProvider.carousel_option_list[
                              carouselProvider.carouselSize - 2]
                        ]);
                        await saveImageToGallery(
                            splitImageProvider.encodedImages, context);
                        context.read<ImagePickerProvider>().deleteImage();
                        adSettingsProvider.reset_number_of_images_download();
                      }
                    } else {
                      await AmplitudeConnection.save_images_button_tapped(
                          gridProvider.grid_or_carousel,
                          gridProvider
                              .grid_option_list[gridProvider.selectedRow - 2],
                          carouselProvider.carousel_option_list[
                              carouselProvider.carouselSize - 2]);
                      adSettingProvider.increamentGridImageDownload();
                      await saveImageToGallery(
                          splitImageProvider.encodedImages, context);
                      await ImageSaveDialog(
                          context, "Pictures saved to your gallery");

                      //Navigator.pop(context);
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
