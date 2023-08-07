import 'package:flutter/material.dart';
import 'package:gridapp/components/amplitude/amplitude.dart';
import 'package:gridapp/provider/first_open_provider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../screens/bottom_navigation_bar.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    var firstOpenProvider = context.read<FirstOpenProvider>();
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: 0,
          minimumSize: Size(
            MediaQuery.of(context).size.width * 0.85,
            MediaQuery.of(context).size.height * 0.07,
          ), // Size(width, height)
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
      child: Text(
        "Get Started",
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      onPressed: () async {
        await AmplitudeConnection.get_started_tapped();
        firstOpenProvider.setShared();
        Navigator.pushReplacement(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: CustomBottomNavigatonBar(),
            duration: Duration(milliseconds: 300),
            reverseDuration: Duration(milliseconds: 300),
          ),
        );
      },
    );
  }
}
