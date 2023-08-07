import 'package:amplitude_flutter/amplitude.dart';
import 'package:flutter/material.dart';
import 'package:gridapp/components/amplitude/amplitude.dart';
import 'package:gridapp/constants/constants.dart';

import '../components/settings/settings_buttons.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/icons8-minus-48.png"),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                "Settings",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SettingsButton(context, "assets/settingsAsset/rate-us-icon.png",
                "Did you like our app?",0),
            SizedBox(
              height: 10,
            ),
            SettingsButton(
                context,
                "assets/settingsAsset/privacy-policy-icon.png",
                "Privacy Policy",1),
            SettingsButton(
                context,
                "assets/settingsAsset/terms-of-service-icon.png",
                "Term Of Service",2),
            SettingsButton(context, "assets/settingsAsset/contact-us-icon.png",
                "Contact Us",3),
          ],
        ),
      ),
    );
  }
}

Future bottomSheet(BuildContext context) {
  return showModalBottomSheet(
    isScrollControlled: true,
    elevation: 1,
    barrierColor: Colors.black,
    backgroundColor: backgroundColor,
    context: context,
    builder: (context) => Container(
      height: MediaQuery.of(context).size.height * 0.95,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/icons8-minus-48.png"),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              "Settings",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SettingsButton(context, "assets/settingsAsset/rate-us-icon.png",
              "Did you like our app?", 0),
          SizedBox(
            height: 10,
          ),
          SettingsButton(context,
              "assets/settingsAsset/privacy-policy-icon.png", "Privacy Policy",1),
          SettingsButton(
              context,
              "assets/settingsAsset/terms-of-service-icon.png",
              "Term Of Service",2),
          SettingsButton(context, "assets/settingsAsset/contact-us-icon.png",
              "Contact Us",3),
        ],
      ),
    ),
  ).then((value) async {
    await AmplitudeConnection.settings_closed();
  });
}
