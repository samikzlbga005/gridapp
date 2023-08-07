import 'package:flutter/material.dart';

Widget OnBoardingItems(String image, String TextBold, String ExplainText) {
  return Padding(
    padding: const EdgeInsets.only(top: 40),
    child: Row(
      children: [
        Image.asset(
          image,
          scale: 2.5,
          width: 100,
        ),
        //SizedBox(
        //  width: 0,
        // ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                TextBold,
                softWrap: true,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                ExplainText,
                softWrap: true,
                textAlign: TextAlign.justify,
                style:
                    TextStyle(color: const Color.fromARGB(255, 111, 111, 111)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
