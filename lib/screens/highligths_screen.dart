import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:gridapp/components/highlights/all_highlights.dart';
import 'package:gridapp/constants/constants.dart';
import 'package:gridapp/provider/cover_pack_provider.dart';
import 'package:provider/provider.dart';

import '../components/remote_config/remote_config_service.dart';

class HighLigths extends StatefulWidget {
  const HighLigths({super.key});

  @override
  State<HighLigths> createState() => _HighLigthsState();
}

class _HighLigthsState extends State<HighLigths> {
  late RemoteConfigService remoteService;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    remoteService = RemoteConfigService();
    
  }

  @override
  Widget build(BuildContext context) {
    var packProvider = context.watch<PacksProvider>();
    return FutureBuilder(
        future: packProvider.remoteService.setRemoteConfig(),
        builder: (context, AsyncSnapshot<FirebaseRemoteConfig> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              backgroundColor: backgroundColor,
              body: Center(
                  child: CircularProgressIndicator(
                color: Colors.white,
              )),
            );
          }
          if (snapshot.hasData) {
            
            return AllHighlights();
          }
          return Center(
            child: Text("err"),
          );
        });
  }
}
