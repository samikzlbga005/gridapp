import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:gridapp/models/special_cover_pack_model.dart';
import 'package:gridapp/provider/cover_pack_provider.dart';
import 'package:provider/provider.dart';

class SingleHighLight extends StatelessWidget {
  final int index;
  final List<HighlightsCovers> list;
  const SingleHighLight({super.key, required this.index, required this.list});

  @override
  Widget build(BuildContext context) {
    var coverPack = context.watch<PacksProvider>();

    return Container(
      width: MediaQuery.of(context).size.width * 0.15,
      height: MediaQuery.of(context).size.height * 0.15,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(list[index].highlightImage.toString()),
        ),
      ),
    );
  }
}
