import 'package:flutter/material.dart';
import 'package:gridapp/provider/grid_provider.dart';
import 'package:provider/provider.dart';
import 'carousel_button.dart';

class MainScreenCarousels extends StatelessWidget {
  const MainScreenCarousels({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GridProvider>(context);
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width * 0.95,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 52, 52, 57),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CarouselButton(image: provider.carouselList[0], index: 0),
                CarouselButton(image: provider.carouselList[1], index: 1),
                CarouselButton(image: provider.carouselList[2], index: 2),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CarouselButton(image: provider.carouselList[3], index: 3),
                CarouselButton(image: provider.carouselList[4], index: 4),
                CarouselButton(image: provider.carouselList[5], index: 5),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
