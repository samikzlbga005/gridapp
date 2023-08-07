import 'dart:math';

import 'package:dio/dio.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:gridapp/components/highlights/download_highlights.dart';
import 'package:gridapp/constants/constants.dart';
import 'package:gridapp/models/special_cover_pack_model.dart';
import 'package:gridapp/provider/ad_settings_provider.dart';
import 'package:gridapp/provider/cover_pack_provider.dart';
import 'package:gridapp/provider/rate_us_provider.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../components/ads/unity_ads.dart';
import '../components/amplitude/amplitude.dart';
import '../components/go_to_settings.dart';
import '../components/highlights/highlight_single_picture.dart';
import '../components/image_saved_dialog.dart';
import '../components/show_dialog.dart';

class AllSpecialHighlights extends StatefulWidget {
  final String name;
  final String order;
  const AllSpecialHighlights(
      {super.key, required this.name, required this.order});

  @override
  State<AllSpecialHighlights> createState() => _AllSpecialHighlights();
}

class _AllSpecialHighlights extends State<AllSpecialHighlights> {
  int currentPage = 0;

  int itemsPerPge = 24;
  int totalItems = 30;
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
    var coverProvider = context.watch<PacksProvider>();
    totalItems = coverProvider.all_images_cover.length;
    final _controller = PageController();
    var adSettingsProvider = context.watch<AdSettingsProvider>();
    var adSettingsProviderread = context.read<AdSettingsProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text(
          widget.name,
          style: TextStyle(fontSize: 28),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () async{
            await AmplitudeConnection.back_icon_tapped();
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(15),
            height: MediaQuery.of(context).size.height * 0.75,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.67,
                    child: PageView.builder(
                      pageSnapping: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: (totalItems / itemsPerPge).ceil(),
                      controller: _controller,
                      onPageChanged: (index) async {
                        setState(() {
                          currentPage = index;
                        });
                        await AmplitudeConnection.highlight_cover_pack_swiped(
                            widget.name, widget.order, index + 1);
                      },
                      itemBuilder: (context, pageIndex) {
                        int start = pageIndex * itemsPerPge;
                        int end = min(start + itemsPerPge, totalItems);
                        return GridView.count(
                          shrinkWrap: false,
                          physics: NeverScrollableScrollPhysics(),
                          crossAxisCount: 4,
                          mainAxisSpacing:
                              MediaQuery.of(context).size.width * 0.05,
                          crossAxisSpacing:
                              MediaQuery.of(context).size.width * 0.05,
                          children: List.generate(
                            end - start,
                            (index) {
                              return GestureDetector(
                                onTap: () async {
                                  await AmplitudeConnection
                                      .highlight_cover_tapped(
                                          widget.name,
                                          widget.order,
                                          coverProvider
                                              .all_images_cover[start + index]
                                              .highlightCoverName
                                              .toString(),
                                          coverProvider
                                              .all_images_cover[start + index]
                                              .order
                                              .toString());
                                  if (await isAccess()) {
                                    if (adSettingsProviderread
                                        .showAddHighLightsStatement()) {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback(
                                              (timeStamp) async {
                                        await AdManager.loadUnityAd();
                                      });
                                      adSettingsProvider.index_highlight =
                                          start + index;
                                      await ShowPopUp(
                                          context,
                                          "You need to watch a video ad to continue to download highlight covers",
                                          "Cancel",
                                          "Continue",
                                          true, [
                                        widget.name,
                                        widget.order,
                                        coverProvider
                                            .all_images_cover[start + index]
                                            .highlightCoverName
                                            .toString(),
                                        coverProvider
                                            .all_images_cover[start + index]
                                            .order
                                            .toString()
                                      ]);
                                      setState(() {});
                                    } else {
                                      print("reklamsız single cover calisti");
                                      adSettingsProviderread
                                          .increamentHighLightsImageDownload();
                                      saveHighLightsImageToGallery(
                                          coverProvider
                                              .all_images_cover[start + index]
                                              .highlightImage
                                              .toString(),
                                          [
                                            widget.name,
                                            widget.order,
                                            coverProvider
                                                .all_images_cover[start + index]
                                                .highlightCoverName
                                                .toString(),
                                            coverProvider
                                                .all_images_cover[start + index]
                                                .order
                                                .toString()
                                          ],
                                          context);
                                      await HighLightsSaveDialog(
                                          context, "Cover saved successfully");
                                    }
                                  } else {
                                    showPermissionPermanentlyDeniedDialog(
                                        context);
                                  }
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.15,
                                  height:
                                      MediaQuery.of(context).size.height * 0.15,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(coverProvider
                                          .all_images_cover[start + index]
                                          .highlightImage
                                          .toString()),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SmoothPageIndicator(
                  controller: _controller,
                  count: (totalItems / itemsPerPge).ceil(),
                  effect: ScrollingDotsEffect(
                    dotHeight: 7,
                    dotWidth: 7,
                    activeDotColor:
                        Colors.white, // Set the color for the active dot
                    dotColor: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          DownloadHighlights(
            imageList: coverProvider.ImagesUrl,
            name: widget.name,
            order: widget.order,
          )
        ],
      ),
    );
  }
}

void saveHighLightsImageToGallery(
    String imageUrl, List<dynamic> packsFeature, BuildContext context) async {
  var rateUsProvider = context.read<RateUsProvider>();
  try {
    var response = await Dio()
        .get(imageUrl, options: Options(responseType: ResponseType.bytes));
    final result = await ImageGallerySaver.saveImage(response.data);
    if (result != null) {
      print('Image saved to gallery.');
    } else {
      print('Failed to save image to gallery.');
    }
  } catch (e) {
    print('Error saving image: $e');
  }
  await AmplitudeConnection.highlight_cover_saved(
    packsFeature[0],
    packsFeature[1],
    packsFeature[2],
    packsFeature[3],
  );
  await rateUsProvider.increamentCoverSaved();
}

Future<void> AllImagesSaveImageToGallery(List<String> imageList,
    BuildContext context, List<dynamic> packsFeature) async {
  var rateUsProvider = context.read<RateUsProvider>();
  for (var i = 0; i < 5; i++) {
    try {
      var response = await Dio().get(imageList[i],
          options: Options(responseType: ResponseType.bytes));
      final result = await ImageGallerySaver.saveImage(response.data);
      if (result != null) {
      } else {
        print('Failed to save image to gallery.');
      }
    } catch (e) {
      print('Error saving image: $e');
    }
  }
  await AmplitudeConnection.all_highlight_covers_saved(
      packsFeature[0], packsFeature[1]);
  await rateUsProvider.increamentAllCoverDownload();
}

Future<bool> isAccess() async {
  if (await Permission.storage.request().isGranted) {
    return true;
  } else {
    PermissionStatus status = await Permission.storage.request();
    if (status.isGranted) {
      return true;
    } else {
      return false;
    }
  }
}
