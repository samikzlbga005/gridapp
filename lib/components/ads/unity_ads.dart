import 'package:flutter/material.dart';
import 'package:gridapp/components/amplitude/amplitude.dart';
import 'package:gridapp/provider/grid_provider.dart';
import 'package:provider/provider.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';

import '../image_saved_dialog.dart';

class AdManager {
  static Future<void> loadUnityAd() async {
    await UnityAds.load(
      placementId: 'Rewarded_Android',
      onComplete: (placementId) => print('Load Complete $placementId'),
      onFailed: (placementId, error, message) =>
          print('Load Failed $placementId: $error $message'),
    );
  }

  static Future<void> runApmlitudeCodesCover(
      List<dynamic> coverSettingsList, String val) async {
    await AmplitudeConnection.video_ad_started_completed_failed_skipped(
      null,
      true,
      coverSettingsList[0],
      coverSettingsList[1],
      coverSettingsList[2],
      coverSettingsList[3],
      null,
      null,
      val,
    );
  }

  static Future<void> runApmlitudeCodesGridCarousel(
      List<dynamic> gridCarouselListSettings,
      String val,
      bool gridOrCarousel) async {
    await AmplitudeConnection.video_ad_started_completed_failed_skipped(
      gridOrCarousel,
      null,
      null,
      null,
      null,
      null,
      gridCarouselListSettings[1],
      gridCarouselListSettings[2],
      val,
    );
  }

  static Future<void> runAmplitudeAllCovers(
      List<dynamic> allCovers, String val) async {
    await AmplitudeConnection.video_ad_started_completed_failed_skipped(
      null,
      false,
      allCovers[0],
      allCovers[1],
      null,
      null,
      null,
      null,
      val,
    );
  }

  static Future<void> ShowVideoAdCover(
      BuildContext context, List<dynamic> coverSettingsList) async {
    UnityAds.showVideoAd(
        placementId: 'Rewarded_Android',
        onStart: (placementId) async {
          await runApmlitudeCodesCover(coverSettingsList, "video_ad_started");

          print('Video Ad $placementId started');
        },
        onClick: (placementId) async {
          print('Video Ad $placementId click');
        },
        onSkipped: (placementId) async {
          await runApmlitudeCodesCover(coverSettingsList, "video_ad_skipped");
          print('Video Ad $placementId skipped');
        },
        onComplete: (placementId) async {
          await HighLightsSaveDialog(context, "Cover saved to your gallery");
          await runApmlitudeCodesCover(coverSettingsList, "video_ad_completed");
          Navigator.pop(context);
        },
        onFailed: (placementId, error, message) async {
          await runApmlitudeCodesCover(coverSettingsList, "video_ad_failed");
          print('Video Ad $placementId failed: $error $message');
        });
  }

  static Future<void> ShowVideoAd(
      BuildContext context, List<dynamic> gridCarouselListSettings) async {
    UnityAds.showVideoAd(
        placementId: 'Rewarded_Android',
        onStart: (placementId) async {
          await runApmlitudeCodesGridCarousel(gridCarouselListSettings,
              "video_ad_started", gridCarouselListSettings[0]);
          print('Video Ad $placementId started');
        },
        onClick: (placementId) async {
          print('Video Ad $placementId click');
        },
        onSkipped: (placementId) async {
          await runApmlitudeCodesGridCarousel(gridCarouselListSettings,
              "video_ad_skipped", gridCarouselListSettings[0]);
          print('Video Ad $placementId skipped');
        },
        onComplete: (placementId) async {
          await runApmlitudeCodesGridCarousel(gridCarouselListSettings,
              "video_ad_completed", gridCarouselListSettings[0]);
          await ImageSaveDialog(context, "Pictures saved to your gallery");
          //Navigator.pop(context);
        },
        onFailed: (placementId, error, message) async {
          await runApmlitudeCodesGridCarousel(gridCarouselListSettings,
              "video_ad_failed", gridCarouselListSettings[0]);
          print('Video Ad $placementId failed: $error $message');
        });
  }

  static Future<void> ShowVideoAdAllDownload(
      BuildContext context, List<dynamic> allCovers) async {
    UnityAds.showVideoAd(
        placementId: 'Rewarded_Android',
        onStart: (placementId) async {
          await runAmplitudeAllCovers(allCovers, "video_ad_started");
          print('Video Ad $placementId started');
        },
        onClick: (placementId) async {
          print('Video Ad $placementId click');
        },
        onSkipped: (placementId) async {
          await runAmplitudeAllCovers(allCovers, "video_ad_skipped");
          print('Video Ad $placementId skipped');
        },
        onComplete: (placementId) async {
          //all covers download
          await runAmplitudeAllCovers(allCovers, "video_ad_completed");
        },
        onFailed: (placementId, error, message) async {
          await runAmplitudeAllCovers(allCovers, "video_ad_failed");
          print('Video Ad $placementId failed: $error $message');
        });
  }
}
