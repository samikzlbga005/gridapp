import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/remote_config/remote_config_service.dart';
import '../models/rate_us_model.dart';
import '../screens/did_you_like.dart';

class RateUsProvider extends ChangeNotifier {
  final FirebaseRemoteConfig remoteConfigData = FirebaseRemoteConfig.instance;
  RemoteConfigService remoteService = RemoteConfigService();
  late AsyncSnapshot<FirebaseRemoteConfig> snapshot;

  late SharedPreferences prefs;

  late RateUs rateUsModel;
  Future<RateUs> getRateDialogSettings() async {
    rateUsModel = await RateUs.fromJson(
        jsonDecode(remoteConfigData.getString("rate_dialog_settings")));
    print(rateUsModel);
    return rateUsModel;
  }

  late int number_of_saved_image_flow;
  late int number_of_saved_cover;
  late int number_of_download_all_cover;

  bool isImageFirst = false;
  bool isCoverFirst = false;
  bool isAllDownload = false;

  bool isClosedDrag = false;

  Future<void> get_number_of_image_num() async {
    prefs = await SharedPreferences.getInstance();
    number_of_saved_image_flow =
        prefs.getInt("number_of_saved_image_flow") ?? 0;
    print("number_of_saved_image_flow: $number_of_saved_image_flow");
  }

  Future<void> set_number_of_image_num(int num) async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setInt("number_of_saved_image_flow", num);
  }

  Future<void> increamentImageSavedFlow() async {
    if (rateUsModel.imageSavedFlow!) {
      number_of_saved_image_flow += 1;
    }
    set_number_of_image_num(number_of_saved_image_flow);
    notifyListeners();
  }

  Future<bool> isEqualToImageSaveFlow() async {
    if (number_of_saved_image_flow == rateUsModel.imageSavedFlowFirstX) {
      return true;
    } else if (number_of_saved_image_flow ==
        rateUsModel.imageSavedFlowSecondX) {
      isImageFirst = true;
      return true;
    } else {
      return false;
    }
  }

  Future<void> reset_number_of_saved_flow() async {
    number_of_saved_image_flow = 0;
    set_number_of_image_num(number_of_saved_image_flow);
  }

  bool isShowDialog = false;
  Future<void> ShowRateDialog(BuildContext contextt, bool? isval) async {
    if (await isEqualToImageSaveFlow()) {
      await RatebottomSheet(contextt, isval);
      if (isImageFirst) {
        await reset_number_of_saved_flow();
        isImageFirst = true;
      }
      print("number_of_saved_image_flow: $number_of_saved_image_flow");
      print(number_of_saved_image_flow);
      isImageFirst = true;
    } else if (await isEqualToCoverSaved()) {
      await RatebottomSheet(contextt, isval);
      if (isCoverFirst) {
        await reset_number_of_cover_saved();
        isCoverFirst = false;
      }
      print(
          "number_of_saved_cover:number_of_saved_cover $number_of_saved_cover");
      print(number_of_saved_cover);
    } else {
      print("not rated");
    }
    isShowDialog = true;
  }

  Future<void> ShowAllDownloadRate(BuildContext contextt, bool? isval) async {
    if (await isEqualToAllCoverSaved()) {
      await RatebottomSheet(contextt, isval);
      if (isAllDownload) {
        await reset_number_of_all_cover_saved();
        isAllDownload = false;
      }
      print("number_of_download_all_coverssss: $number_of_download_all_cover");
      print(number_of_download_all_cover);
    } else {
      print("not rated");
    }
  }

  //single cover
  Future<void> get_number_of_cover_num() async {
    prefs = await SharedPreferences.getInstance();
    number_of_saved_cover = prefs.getInt("number_of_saved_cover") ?? 0;
    print("number_of_saved_cover: $number_of_saved_cover");
  }

  Future<void> set_number_of_cover_num(int num) async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setInt("number_of_saved_cover", num);
  }

  Future<void> increamentCoverSaved() async {
    if (rateUsModel.highlightCoverSavedFlow!) {
      number_of_saved_cover += 1;
    }
    set_number_of_cover_num(number_of_saved_cover);
    notifyListeners();
  }

  Future<bool> isEqualToCoverSaved() async {
    if (number_of_saved_cover == rateUsModel.highlightCoverSavedFlowFirstX) {
      return true;
    } else if (number_of_saved_cover ==
        rateUsModel.highlightCoverSavedFlowSecondX) {
      isCoverFirst = true;
      return true;
    } else {
      return false;
    }
  }

  Future<void> reset_number_of_cover_saved() async {
    number_of_saved_cover = 0;
    set_number_of_cover_num(number_of_saved_cover);
  }

  //all cover
  Future<void> get_number_of_all_cover() async {
    prefs = await SharedPreferences.getInstance();
    number_of_download_all_cover =
        prefs.getInt("number_of_download_all_cover") ?? 0;
    print("number_of_download_all_cover: $number_of_download_all_cover");
  }

  Future<void> set_number_of_all_cover(int num) async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setInt("number_of_download_all_cover", num);
    print("number_of_download_all_cover: $number_of_download_all_cover");
  }

  Future<void> increamentAllCoverDownload() async {
    if (rateUsModel.highlightCoverPackSavedFlow!) {
      number_of_download_all_cover += 1;
    }
    set_number_of_all_cover(number_of_download_all_cover);
    notifyListeners();
  }

  Future<bool> isEqualToAllCoverSaved() async {
    if (number_of_download_all_cover ==
        rateUsModel.highlightCoverPackSavedFlowFirstX) {
      return true;
    } else if (number_of_download_all_cover ==
        rateUsModel.highlightCoverPackSavedFlowSecondX) {
      isAllDownload = true;
      return true;
    } else {
      return false;
    }
  }

  Future<void> reset_number_of_all_cover_saved() async {
    number_of_download_all_cover = 0;
    set_number_of_all_cover(number_of_download_all_cover);
  }
}
