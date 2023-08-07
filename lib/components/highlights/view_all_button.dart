import 'package:flutter/material.dart';
import 'package:gridapp/components/amplitude/amplitude.dart';
import 'package:gridapp/models/special_cover_pack_model.dart';
import 'package:gridapp/provider/cover_pack_provider.dart';
import 'package:gridapp/screens/all_special_highlights.dart';
import 'package:provider/provider.dart';

class ViewAllButton extends StatelessWidget {
  final String name;
  final int index;
  const ViewAllButton({super.key, required this.name, required this.index});

  @override
  Widget build(BuildContext context) {
    var packProvider = context.watch<PacksProvider>();
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: 0,
          minimumSize: Size(
            MediaQuery.of(context).size.width * 0.75,
            MediaQuery.of(context).size.height * 0.06,
          ),
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
      child: Text(
        "View All",
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      onPressed: () async {
        await context.read<PacksProvider>().all_images(name, index);

        await context
            .read<PacksProvider>()
            .getImagesUrl(packProvider.all_images_cover);
        await AmplitudeConnection.highlight_cover_pack_opened(
            packProvider.cover_pack_list[index].CoverPackName.toString(),
            packProvider.cover_pack_list[index].order.toString());
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AllSpecialHighlights(
              name: name,
              order: packProvider.cover_pack_list[index].order.toString(),
            ),
          ),
        );
      },
    );
  }
}
