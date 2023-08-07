import 'package:flutter/material.dart';
import 'package:gridapp/components/grid/grid_button.dart';
import 'package:gridapp/provider/grid_provider.dart';
import 'package:provider/provider.dart';

class MainScreenGrids extends StatelessWidget {
  const MainScreenGrids({super.key});

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
                GridButton(image: provider.imagesLigth[0], index: 0, task: 1),
                GridButton(image: provider.imagesLigth[1], index: 1, task: 1),
                GridButton(image: provider.imagesLigth[2], index: 2, task: 1),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GridButton(image: provider.imagesLigth[3], index: 3, task: 1),
                GridButton(image: provider.imagesLigth[4], index: 4, task: 1),
                GridButton(image: provider.imagesLigth[5], index: 5, task: 1),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
