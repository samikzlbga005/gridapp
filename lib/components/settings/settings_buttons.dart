import 'package:flutter/material.dart';
import 'package:gridapp/components/amplitude/amplitude.dart';

import '../../screens/did_you_like.dart';

Widget SettingsButton(
        BuildContext context, String image, String text, int val) =>
    Padding(
      padding: const EdgeInsets.only(right: 10, left: 10),
      child: GestureDetector(
        onTap: () async {
          switch (val) {
            case 0:
              await AmplitudeConnection.rate_us_tapped();
              break;
            case 1:
              await AmplitudeConnection.privacy_policy_tapped();
              break;
            case 2:
              await AmplitudeConnection.terms_of_services_tapped();
              break;
            case 3:
              await AmplitudeConnection.contact_us_tapped();
              break;
            default:
              print("");
          }

          RatebottomSheet(context, null);
          print("rate");
        },
        child: Container(
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 28, 28, 29),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 0.3, color: Colors.black)),
          height: MediaQuery.of(context).size.height * 0.09,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 15,
              right: 10,
            ),
            child: Row(
              children: [
                Image.asset(
                  image,
                  scale: 1.4,
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  text,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
