import 'package:flutter/material.dart';
import 'package:gridapp/components/amplitude/amplitude.dart';
import 'package:gridapp/screens/edit_screen.dart';
import 'package:provider/provider.dart';

import '../../provider/grid_provider.dart';
import '../../provider/pick_image_provider.dart';

class GridButton extends StatelessWidget {
  final String image;
  final int index;
  final int task;
  const GridButton(
      {super.key,
      required this.image,
      required this.index,
      required this.task});

  //task 0 = > editscreen içerisinde dolaşma
  //diğer tasklar için mainscreenden edit screene yönlendirme
  @override
  Widget build(BuildContext context) {
    var provider = context.read<GridProvider>();
    var imageProvider = context.watch<ImagePickerProvider>();
    return GestureDetector(
      child: Image.asset(
        image,
        scale: 2.8,
      ),
      onTap: () async {
        provider.gridHeight = MediaQuery.of(context).size.height * 0.8;
        provider.selectGrid(index);
        if (task == 0) {
          await provider.changeButton(index);
          provider.isSSelected = true;
          print("${index + 1}. butona basıldı");
          await AmplitudeConnection.grid_option_changed(
              provider.grid_option_list[index]);
        } else {
          if (imageProvider.image != null) {
            imageProvider.image = null;
          }
          await AmplitudeConnection.grid_option_selected(
              provider.grid_option_list[index]);
          provider.openGridPage(index);
          provider.GridCarousel(true);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => EditScreen()));
        }
      },
    );
  }
}
