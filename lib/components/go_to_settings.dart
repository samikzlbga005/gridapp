import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void showPermissionPermanentlyDeniedDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 19, 20, 22),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          content: Text(
            "You have to allow permission for go to gallery",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    minimumSize: Size(
                      MediaQuery.of(context).size.width * 0.3,
                      MediaQuery.of(context).size.height * 0.06,
                    ), // Size(width, height)
                    backgroundColor: const Color.fromARGB(255, 38, 38, 38),
                  ),
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    minimumSize: Size(
                      MediaQuery.of(context).size.width * 0.3,
                      MediaQuery.of(context).size.height * 0.06,
                    ), // Size(width, height)
                    backgroundColor: const Color.fromARGB(255, 38, 38, 38),
                  ),
                  child: Text(
                    "Go to settings",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    openAppSettings();
                  },
                ),
              ],
            ),
          ]);
    },
  );
}
