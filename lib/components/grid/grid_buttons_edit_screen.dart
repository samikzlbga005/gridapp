import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:gridapp/provider/grid_provider.dart';
import 'package:provider/provider.dart';
import 'grid_button.dart';

class GridButtons extends StatefulWidget {
  const GridButtons({super.key});

  @override
  State<GridButtons> createState() => _GridButtonsState();
}

class _GridButtonsState extends State<GridButtons> {
  @override
  Widget build(BuildContext context) {
    var provider = context.watch<GridProvider>();
    List<dynamic> list = [];
    Future<List<dynamic>> getList() async {
      for (var i = 0; i < provider.showImageList.length; i++) {
        list.add(provider.showImageList[i]);
      }
      return list;
    }
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: FutureBuilder(
          future: getList(),
          builder: (context, AsyncSnapshot<List> snapshot) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GridButton(image: list[0], index: 0, task: 0),
                GridButton(image: list[1], index: 1, task: 0),
                GridButton(image: list[2], index: 2, task: 0),
                GridButton(image: list[3], index: 3, task: 0),
                GridButton(image: list[4], index: 4, task: 0),
                GridButton(image: list[5], index: 5, task: 0),
              ],
            );
          }),
    );
  }
}
