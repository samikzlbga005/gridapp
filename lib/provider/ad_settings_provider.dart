import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:gridapp/models/ad_settings_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/remote_config/remote_config_service.dart';

class AdSettingsProvider extends ChangeNotifier {
  final FirebaseRemoteConfig remoteConfigData = FirebaseRemoteConfig.instance;
  final RemoteConfigService remoteService = RemoteConfigService();
  late AsyncSnapshot<FirebaseRemoteConfig> snapshot;

  bool singleCoverRewardedAd = false;
  int singleCoverRewardedAdX = 0;

  bool downloadAllCoversRewardedAd = false;

  bool exportedImageRewardedAd = false;
  int exportedImageRewardedAdX = 0;

  List<dynamic> settings_decode_list = [];
  List<AdSettings> asd = [];

  late SharedPreferences prefs;

  Future<void> getSettings() async {
    singleCoverRewardedAd = jsonDecode(
        remoteConfigData.getString("ad_settings"))["singleCoverRewardedAd"];
    singleCoverRewardedAdX = jsonDecode(
        remoteConfigData.getString("ad_settings"))["singleCoverRewardedAdX"];

    downloadAllCoversRewardedAd =
        jsonDecode(remoteConfigData.getString("ad_settings"))[
            "downloadAllCoversRewardedAd"];
    exportedImageRewardedAd = jsonDecode(
        remoteConfigData.getString("ad_settings"))["exportedImageRewardedAd"];
    exportedImageRewardedAdX = jsonDecode(
        remoteConfigData.getString("ad_settings"))["exportedImageRewardedAdX"];
  }

  int number_of_download_image = 1;
  //highlights download

  int number_of_highlights_download = 1;
  int index_highlight = 0;

  //All Highlights
  bool isDownloadAll = false;
  List<String> downloadedAllHighlights = [];

  void increamentGridImageDownload() {
    number_of_download_image += 1;
    setNumberOfDownloadImage(number_of_download_image);
  }

  bool showAddGridStatement() {
    if (exportedImageRewardedAd) {
      if (number_of_download_image == exportedImageRewardedAdX) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  void reset_number_of_images_download() {
    number_of_download_image = 1;
    setNumberOfDownloadCover(number_of_highlights_download);
  }

  void increamentHighLightsImageDownload() {
    if (exportedImageRewardedAd) {
      number_of_highlights_download += 1;
      setNumberOfDownloadCover(number_of_highlights_download);
    } else {}
  }

  bool showAddHighLightsStatement() {
    if (singleCoverRewardedAd) {
      if (number_of_highlights_download == singleCoverRewardedAdX) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  void reset_number_of_highlights_download() {
    if (singleCoverRewardedAd) {
      number_of_highlights_download = 1;
      setNumberOfDownloadCover(number_of_highlights_download);
    } else {}
  }

  //preferences

  //prefs cover
  Future<void> setNumberOfDownloadCover(int num) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt("downloaded_cover_num", num);
    notifyListeners();
  }

  Future<void> getNumberOfDownloadCover() async {
    prefs = await SharedPreferences.getInstance();
    number_of_highlights_download =
        await prefs.getInt("downloaded_cover_num") ?? 1;
  }

  //prefs image

  Future<void> setNumberOfDownloadImage(int num) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt("downloaded_image_num", num);
    notifyListeners();
  }

  Future<void> getNumberOfDownloadImage() async {
    prefs = await SharedPreferences.getInstance();
    number_of_download_image = await prefs.getInt("downloaded_image_num") ?? 1;
    print(" shared image: $number_of_download_image");
  }

  notifyListeners();
}
