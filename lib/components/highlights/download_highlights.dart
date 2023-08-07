import 'package:flutter/material.dart';
import 'package:gridapp/components/all_highlights_dialog.dart';
import 'package:gridapp/provider/ad_settings_provider.dart';
import 'package:gridapp/provider/cover_pack_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../screens/all_special_highlights.dart';
import '../ads/unity_ads.dart';
import '../amplitude/amplitude.dart';
import '../go_to_settings.dart';
import '../image_saved_dialog.dart';

class DownloadHighlights extends StatefulWidget {
  final List<String> imageList;
  final String name;
  final String order;
  const DownloadHighlights(
      {super.key,
      required this.imageList,
      required this.order,
      required this.name});

  @override
  State<DownloadHighlights> createState() => _DownloadHighlightsState();
}

class _DownloadHighlightsState extends State<DownloadHighlights> {
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
    var adSettings = context.watch<AdSettingsProvider>();
    var packProvider = context.watch<PacksProvider>();

    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 0,
            minimumSize: Size(
              MediaQuery.of(context).size.width * 0.75,
              MediaQuery.of(context).size.height * 0.06,
            ),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50))),
        child: adSettings.isDownloadAll
            ? Container(
                width: MediaQuery.of(context).size.width * 0.65,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Downloading Covers...",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  ],
                ),
              )
            : Text(
                "Download All",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
        onPressed: () async {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
            await AdManager.loadUnityAd();
          });
          await AmplitudeConnection.download_all_highlight_covers_tapped(
              widget.name, widget.order);
          if (await isAccess()) {
            if (context
                .read<AdSettingsProvider>()
                .downloadAllCoversRewardedAd) {
              setState(() {
                adSettings.isDownloadAll = true;
              });
              await AllHighLightsPopUp(
                  context,
                  "To download all highlights covers in this pack you need to watch a video ad",
                  widget.imageList,
                  [widget.name, widget.order]);
              setState(() {});

              if (packProvider.isAllDownload) {
                await AllImagesSaveImageToGallery(
                    widget.imageList, context, [widget.name, widget.order]);
                setState(() {
                  adSettings.isDownloadAll = false;
                  packProvider.isAllDownload = false;
                });
                await HighLightsPackSaveDialog(
                    context, "All Image saved successfully");
              }
            } else {
              setState(() {
                adSettings.isDownloadAll = true;
              });
              await AllImagesSaveImageToGallery(
                  widget.imageList, context, [widget.name, widget.order]);
              setState(() {
                adSettings.isDownloadAll = false;
              });
              await HighLightsPackSaveDialog(
                  context, "All covers saved to your gallery");
            }
          } else {
            showPermissionPermanentlyDeniedDialog(context);
          }
        });
  }
}
