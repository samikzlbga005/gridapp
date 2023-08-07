import 'package:flutter/material.dart';
import 'package:gridapp/components/highlights/view_all_button.dart';
import 'package:gridapp/provider/cover_pack_provider.dart';
import 'package:provider/provider.dart';

import '../../models/special_cover_pack_model.dart';

class HighLigthsTemplate extends StatelessWidget {
  final int index_cover_packs;
  final List<HighlightsCovers> list;
  const HighLigthsTemplate(
      {super.key, required this.index_cover_packs, required this.list});

  @override
  Widget build(BuildContext context) {
    var coverPackProvider = context.watch<PacksProvider>();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                coverPackProvider
                    .cover_pack_list[index_cover_packs].CoverPackName
                    .toString(),
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              Text(
                "${((coverPackProvider.special_covers[index_cover_packs].length))}x Highlights",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              height: MediaQuery.of(context).size.height * 0.35,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 81, 78, 78),
                  borderRadius: BorderRadius.circular(10)),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      top: 30,
                      right: 30,
                      left: 30,
                    ),
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 4,
                      mainAxisSpacing: MediaQuery.of(context).size.width * 0.05,
                      crossAxisSpacing:
                          MediaQuery.of(context).size.width * 0.05,
                      children: List.generate(
                        8,
                        (index) {
                          return Container(
                            width: MediaQuery.of(context).size.width * 0.15,
                            height: MediaQuery.of(context).size.height * 0.15,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: Image.network(list[index]
                                            .highlightImage
                                            .toString() //coverPackProvider.highlightsCovers[index_cover_packs].highlightImage!.toString(),
                                        )
                                    .image,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ViewAllButton(
                    name: coverPackProvider
                        .cover_pack_list[index_cover_packs].CoverPackName
                        .toString(),
                    index: index_cover_packs,
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
