import 'package:flutter/material.dart';

import '../components/carousel/main_screen_carousels.dart';
import '../components/grid/main_screen_grids.dart';
import '../constants/constants.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //final provider = Provider.of<GridProvider>(context);
    //provider.grid_picture_size();
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0, bottom: 5.0),
                    child: Text(
                      "Grids",
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  ),
                  MainScreenGrids(),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 5.0, bottom: 5.0, top: 20),
                    child: Text(
                      "Carousels",
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  ),
                  MainScreenCarousels(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
