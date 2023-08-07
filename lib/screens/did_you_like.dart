import 'package:flutter/material.dart';
import 'package:gridapp/components/amplitude/amplitude.dart';
import 'package:gridapp/provider/grid_provider.dart';
import 'package:gridapp/provider/rate_us_provider.dart';
import 'package:provider/provider.dart';

import '../components/image_saved_dialog.dart';

Future RatebottomSheet(BuildContext contextt, bool? isgGridOrCover) async {
  await AmplitudeConnection.rate_dialog_triggered(isgGridOrCover);
  return showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.black,
    elevation: 1,
    context: contextt,
    builder: (context) => Container(
      height: MediaQuery.of(context).size.height * 0.4,
      padding: EdgeInsets.only(bottom: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("assets/icons8-minus-48.png"),
            ],
          ),
          Text(
            "Did you like our app?",
            style: TextStyle(
                color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
          ),
          Column(
            children: [
              Text(
                "Your feedback is important to us!",
                style: TextStyle(color: Colors.grey, fontSize: 17),
              ),
              Text(
                "Please share your opinion",
                style: TextStyle(color: Colors.grey, fontSize: 17),
              ),
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 0,
                minimumSize: Size(
                  MediaQuery.of(context).size.width * 0.8,
                  MediaQuery.of(context).size.height * 0.06,
                ), // Size(width, height)
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50))),
            child: Text(
              "Yes I like it",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            onPressed: () async {
              context.read<RateUsProvider>().isClosedDrag = true;
              await AmplitudeConnection.rate_dialog_answered(
                  isgGridOrCover, true);
              await ThanksSaveDialog(context, "Thank you for your feedback!");
              Navigator.of(context).pop();
            },
          ),
          GestureDetector(
            onTap: () async {
              context.read<RateUsProvider>().isClosedDrag = true;
              await AmplitudeConnection.rate_dialog_answered(
                  isgGridOrCover, false);
              await ThanksSaveDialog(context, "Thank you for your feedback!");
              Navigator.of(context).pop();
            },
            child: Text(
              "Not really",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    ),
  ).then((value) async {
    if (contextt.read<GridProvider>().gridOrCover) {
      Navigator.pop(contextt);
    }
    if (!contextt.read<RateUsProvider>().isClosedDrag) {
      await AmplitudeConnection.rate_dialog_closed(isgGridOrCover);
    }
  });
}
