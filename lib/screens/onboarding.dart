import 'package:flutter/material.dart';
import 'package:gridapp/components/get_started_button.dart';
import 'package:gridapp/constants/constants.dart';
import 'package:provider/provider.dart';

import '../components/onboarding_items.dart';
import '../provider/ad_settings_provider.dart';
import '../provider/cover_pack_provider.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<PacksProvider>().getPacks();
    context.read<AdSettingsProvider>().getSettings();
    return Scaffold(
      backgroundColor: Color.fromARGB(135, 28, 28, 29),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 50, left: 15, right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Grid Pro+",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 34,
                        fontWeight: FontWeight.bold),
                  ),
                  OnBoardingItems(
                    "assets/onboarding/create_grid_photo.png",
                    OnBoardingBoldText[0],
                    OnBoardingExplain[0],
                  ),
                  OnBoardingItems("assets/onboarding/create_carousel_photo.png",
                      OnBoardingBoldText[1], OnBoardingExplain[1]),
                  OnBoardingItems("assets/onboarding/best_highligth_cover.png",
                      OnBoardingBoldText[2], OnBoardingExplain[2]),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: GetStarted(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
