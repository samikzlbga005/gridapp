import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

import '../components/remote_config/remote_config_service.dart';
import '../models/cover_packs_model.dart';
import '../models/special_cover_pack_model.dart';

/* List<dynamic> packs = [];

  List<String> packName = [];
  Future<void> getImage() async {
    packName.clear();
    packs.clear();
    packs = jsonDecode(
        remoteConfigData.getString("black_ceramic"))["highlights_covers"];
    print(packs);
    for (var i = 0; i < packs.length; i++) {
      print(packs[i]);
      packName.add(Map.from(packs[i])["highlight_cover_name"].toString());
    }

    print("${packName[0]} ok");
  }*/
class PacksProvider extends ChangeNotifier {
  final FirebaseRemoteConfig remoteConfigData = FirebaseRemoteConfig.instance;
  RemoteConfigService remoteService = RemoteConfigService();
  late AsyncSnapshot<FirebaseRemoteConfig> snapshot;
  //remoteService.setRemoteConfig();

  List<dynamic> packs = [];
  List<cover_packs> cover_pack_list = [];
  List<cover_packs> cover_pack_list_ordered = [];
  //all_highlights dosyaasından alınan itembuilder indexi highlights templatede kullanılıyor

  bool isContinue = false;
  List<int> ordered_packs = [];
  Future<List<cover_packs>> getPacks() async {
    packs.clear();
    cover_pack_list.clear();
    cover_pack_list_ordered.clear();
    ordered_packs.clear();
    packs = jsonDecode(
        await remoteConfigData.getString("cover_packs"))["cover_packs"];
    for (var i = 0; i < packs.length; i++) {
      cover_pack_list_ordered.add(cover_packs.fromJson(packs[i]));
      ordered_packs.add(cover_pack_list_ordered[i].order!);
    }
    for (var i = 0; i < cover_pack_list_ordered.length; i++) {
      cover_pack_list.add(cover_pack_list_ordered[ordered_packs[i] - 1]);
    }
    await getSpecialCoverPack();
    return cover_pack_list;
  }

  List<List<dynamic>> special_covers = []; //her bir cover paketinin listesi
  List<String> single_cover_pack_name = [];

  Future<void> getSpecialCoverPack() async {
    special_covers.clear();
    single_cover_pack_name.clear();
    for (var i = 0; i < cover_pack_list.length; i++) {
      single_cover_pack_name.add(cover_pack_list[i].CoverPackName!);

      special_covers.add(jsonDecode(remoteConfigData.getString(
              "${cover_pack_list[i].CoverPackName!.toLowerCase().replaceAll(" ", "_")}"))[
          "highlights_covers"]);
    }
  }

  List<HighlightsCovers> highlightsCovers = [];
  List<HighlightsCovers> getSingleCover(int index) {
    highlightsCovers.clear();
    for (var i = 0; i < 8; i++) {
      highlightsCovers.add(HighlightsCovers.fromJson(special_covers[index][i]));
    }
    return highlightsCovers;
  }

  List<HighlightsCovers> all_images_cover = [];

  Future<void> all_images(String name, int index) async {
    all_images_cover.clear();
    for (var i = 0; i < special_covers[index].length; i++) {
      all_images_cover.add(HighlightsCovers.fromJson(special_covers[index][i]));
    }
  }

  List<String> ImagesUrl = [];
  Future<void> getImagesUrl(List<HighlightsCovers> covers) async {
    ImagesUrl.clear();
    for (var i = 0; i < covers.length; i++) {
      ImagesUrl.add(covers[i].highlightImage.toString());
    }
  }

  bool isAllDownload = false;

  void isDownloadAll() {
    isAllDownload = true;
  }

  notifyListeners();
}

/*
List<List<dynamic>> special_covers = []; //her bir cover paketinin listesi
  List<String> single_cover_pack_name = [];

  List<dynamic> higlihts_cover_list = [];

  Future<void> getSpecialCoverPack() async {
    special_covers.clear();
    single_cover_pack_name.clear();
    for (var i = 0; i < cover_pack_list.length; i++) {
      List<dynamic> single_cover = jsonDecode(remoteConfigData.getString(
              "${cover_pack_list[i].CoverPackName!.toLowerCase().replaceAll(" ", "_")}"))[
          "highlights_covers"];
      single_cover_pack_name.add(cover_pack_list[i].CoverPackName!);
      special_covers.add(single_cover);
      //higlihts_cover_list.add(getSingleCover(i));
    }

    print("special_covers: ${higlihts_cover_list[0]}");
  }

  List<HighlightsCovers> highlightsCovers = [];
  List<HighlightsCovers> getSingleCover(int index) {
    highlightsCovers.clear();
    for (var i = 0; i < special_covers[index].length; i++) {
      highlightsCovers.add(HighlightsCovers.fromJson(special_covers[index][i]));
    }
    return highlightsCovers;
  }


 */