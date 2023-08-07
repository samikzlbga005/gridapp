import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:gridapp/constants/constants.dart';
import 'package:gridapp/provider/ad_settings_provider.dart';
import 'package:gridapp/provider/first_open_provider.dart';
import 'package:gridapp/provider/rate_us_provider.dart';
import 'package:gridapp/screens/main_screen.dart';
import 'package:gridapp/screens/onboarding.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';

import '../components/remote_config/remote_config_service.dart';
import '../provider/cover_pack_provider.dart';
import 'bottom_navigation_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<FirstOpenProvider>(context, listen: false).getShared();
    Provider.of<AdSettingsProvider>(context, listen: false)
        .getNumberOfDownloadCover();
    Provider.of<AdSettingsProvider>(context, listen: false)
        .getNumberOfDownloadImage();
    Provider.of<RateUsProvider>(context, listen: false)
        .get_number_of_image_num();
    Provider.of<RateUsProvider>(context, listen: false)
        .get_number_of_cover_num();
        Provider.of<RateUsProvider>(context, listen: false)
        .get_number_of_all_cover();
  }

  @override
  Widget build(BuildContext context) {
    var firstOpenProvider = context.watch<FirstOpenProvider>();
    context.read<PacksProvider>().getPacks();
    context.read<AdSettingsProvider>().getSettings();
    context.read<RateUsProvider>().getRateDialogSettings();
    return AnimatedSplashScreen(
      splash: Image.asset('assets/splash_screen.png'),
      nextScreen: firstOpenProvider.isNewUserFunction()
          ? CustomBottomNavigatonBar()
          : OnBoardingScreen(),
      backgroundColor: backgroundColor,
      splashIconSize: 125,
      duration: 2000,
    );
  }
}
