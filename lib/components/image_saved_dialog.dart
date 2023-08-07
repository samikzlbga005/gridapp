import 'package:flutter/material.dart';
import 'package:gridapp/provider/grid_provider.dart';
import 'package:gridapp/provider/rate_us_provider.dart';
import 'package:provider/provider.dart';

import '../provider/pick_image_provider.dart';
import '../screens/did_you_like.dart';

Future<void> ImageSaveDialog(BuildContext contextt, String text) async {
  //images save success
  return showDialog(
    context: contextt,
    barrierDismissible: false,
    builder: (BuildContext context) {
      Future.delayed(Duration(seconds: 2), () async {
        if (Navigator.canPop(context)) {
          Navigator.of(context).pop();
        }
        //Navigator.pop(context);
      });
      return AlertDialog(
        backgroundColor: Color.fromARGB(255, 62, 56, 56),
        content: Padding(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      );
    },
  ).then((value) async {
    //await context.read<RateUsProvider>().secondShowRateDialog(context);
    contextt.read<ImagePickerProvider>().deleteImage();
  }).whenComplete(() async {
    print(contextt.read<GridProvider>().grid_or_carousel);
    await contextt.read<RateUsProvider>().ShowRateDialog(
        contextt, contextt.read<GridProvider>().grid_or_carousel);
    if (contextt.read<RateUsProvider>().isShowDialog) {
      print("not worked");
      Navigator.pop(contextt);
    }
  });
}

Future<void> HighLightsSaveDialog(BuildContext contextt, String text) async {
  //images save success
  return showDialog(
    context: contextt,
    barrierDismissible: false,
    builder: (BuildContext context) {
      Future.delayed(Duration(seconds: 2), () async {
        if (Navigator.canPop(context)) {
          Navigator.of(context).pop();
        }
        //Navigator.pop(context);
      });
      return AlertDialog(
        backgroundColor: Color.fromARGB(255, 62, 56, 56),
        content: Padding(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      );
    },
  ).whenComplete(() async {
    await contextt.read<RateUsProvider>().ShowRateDialog(contextt, null);
  });
}

Future<void> HighLightsPackSaveDialog(
    BuildContext contextt, String text) async {
  //images save success
  return showDialog(
    context: contextt,
    barrierDismissible: false,
    builder: (BuildContext context) {
      Future.delayed(Duration(seconds: 2), () async {
        if (Navigator.canPop(context)) {
          Navigator.of(context).pop();
        }
      });
      return AlertDialog(
        backgroundColor: Color.fromARGB(255, 62, 56, 56),
        content: Padding(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      );
    },
  ).whenComplete(() async {
    await contextt.read<RateUsProvider>().ShowAllDownloadRate(contextt, null);
  });
}

Future<void> ThanksSaveDialog(BuildContext context, String text) async {
  //images save success
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      Future.delayed(Duration(seconds: 2), () async {
        if (context.read<GridProvider>().gridOrCover) {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        } else if (context.read<GridProvider>().gridOrCover) {
          Navigator.pop(context);
        } else {
          Navigator.pop(context);
        }
      });
      return AlertDialog(
        backgroundColor: Color.fromARGB(255, 62, 56, 56),
        content: Padding(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      );
    },
  );
}
