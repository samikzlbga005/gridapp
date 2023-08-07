import 'package:flutter/material.dart';
import 'package:gridapp/models/special_cover_pack_model.dart';
import 'package:gridapp/provider/cover_pack_provider.dart';
import 'package:provider/provider.dart';

import '../../provider/ad_settings_provider.dart';
import 'highlights_template.dart';

class AllHighlights extends StatelessWidget {
  const AllHighlights({super.key});

  @override
  Widget build(BuildContext context) {
    var packProvider = context.watch<PacksProvider>();
    List<HighlightsCovers> list = [];
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: packProvider.cover_pack_list.length,
        itemBuilder: (context, index) {
          list.clear();
          list = context.read<PacksProvider>().getSingleCover(index);
          return HighLigthsTemplate(index_cover_packs: index, list: list);
        },
      ),
    );
  }
}
