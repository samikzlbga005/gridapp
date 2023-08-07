import 'dart:async';
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/services.dart';

class RemoteConfigService {
  final StreamController<dynamic> _fetchingError =
      StreamController<dynamic>.broadcast();
  Stream<dynamic> get fetchingErrorStream => _fetchingError.stream;
  StreamController<dynamic> get _fetchingErrorController => _fetchingError;

  Future<FirebaseRemoteConfig> setRemoteConfig() async {
    await Firebase.initializeApp();

    var _remoteConfig = FirebaseRemoteConfig.instance;
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 200),
        minimumFetchInterval: const Duration(minutes: 30)));

    _remoteConfig.fetchAndActivate();

    _remoteConfig.setDefaults(<String, dynamic>{
      "highlight_cover_pack_name": "Black Ceramic",
    });

    RemoteConfigValue(null, ValueSource.valueStatic);
    return _remoteConfig;
  }

  Future<void> onForceFetched(FirebaseRemoteConfig remoteConfig) async {
    try {
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: const Duration(seconds: 0)));
    } on PlatformException catch (e) {
      _fetchingErrorController.add(e.message);
    }
  }
}
