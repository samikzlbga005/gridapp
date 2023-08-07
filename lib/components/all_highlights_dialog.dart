import 'package:amplitude_flutter/amplitude.dart';
import 'package:flutter/material.dart';
import 'package:gridapp/components/amplitude/amplitude.dart';
import 'package:gridapp/provider/cover_pack_provider.dart';
import 'package:provider/provider.dart';

import '../provider/ad_settings_provider.dart';
import '../screens/all_special_highlights.dart';
import 'ads/unity_ads.dart';
import 'image_saved_dialog.dart';

Future<void> AllHighLightsPopUp(BuildContext context, String text,
    List<String> images, List<String> packListSettings) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      var adSettings = context.watch<AdSettingsProvider>();
      return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 19, 20, 22),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          content: Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
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
                      MediaQuery.of(context).size.width * 0.3,
                      MediaQuery.of(context).size.height * 0.06,
                    ), // Size(width, height)
                    backgroundColor: const Color.fromARGB(255, 38, 38, 38),
                  ),
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    adSettings.isDownloadAll = false;
                    await AmplitudeConnection.video_ad_popup_closed(
                        null, false);
                    Navigator.pop(context);
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    minimumSize: Size(
                      MediaQuery.of(context).size.width * 0.3,
                      MediaQuery.of(context).size.height * 0.06,
                    ), // Size(width, height)
                    backgroundColor: const Color.fromARGB(255, 38, 38, 38),
                  ),
                  child: Text(
                    "Continue",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    context.read<PacksProvider>().isDownloadAll();
                    await AdManager.ShowVideoAdAllDownload(
                        context, [packListSettings[0], packListSettings[1]]);
                    await AmplitudeConnection.watch_ad_tapped(
                        null,
                        false,
                        packListSettings[0],
                        packListSettings[1],
                        null,
                        null,
                        null,
                        null);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ]);
    },
  );
}
