import 'package:flutter/material.dart';
import 'package:gridapp/components/amplitude/amplitude.dart';
import 'package:gridapp/components/grid/grid_view_template.dart';
import 'package:gridapp/constants/constants.dart';
import 'package:provider/provider.dart';
import '../components/carousel/carousel_size_button.dart';
import '../components/carousel/carousel_view_template.dart';
import '../components/grid/grid_buttons_edit_screen.dart';
import '../components/save_button.dart';
import '../provider/grid_provider.dart';
import '../provider/pick_image_provider.dart';

class EditScreen extends StatelessWidget {
  const EditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<GridProvider>();
    var imageProvider = context.watch<ImagePickerProvider>();

    //print("gridwidth: ${provider.gridWidth}");
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text(
          "Edit",
          style: TextStyle(fontSize: 24),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () async {
            await AmplitudeConnection.back_icon_tapped();
            context.read<ImagePickerProvider>().deleteImage();
            Navigator.pop(context);
            provider.gridWidth = 500;
          },
          child: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        actions: [
          context.watch<ImagePickerProvider>().image != null
              ? Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: TextButton(
                    onPressed: () async {
                      await AmplitudeConnection.change_image_tapped();
                      context
                          .read<ImagePickerProvider>()
                          .pickImage(context, true);
                    },
                    child: Text(
                      "Change Image",
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ),
                )
              : Text(""),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.95,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.66,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: provider.grid_or_carousel
                          ? Container(
                              width: provider.gridWidth * 0.78,
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  return Container(
                                    height: imageProvider.image != null
                                        ? constraints.maxWidth *
                                            provider.gridRatio
                                        : MediaQuery.of(context).size.height *
                                            0.60,
                                    child: GridViewTemplate(),
                                  );
                                },
                              ),
                            )
                          : LayoutBuilder(
                              builder: (context, constraints) {
                                return Container(
                                  width: imageProvider.image != null
                                      ? constraints.maxWidth
                                      : MediaQuery.of(context).size.width,
                                  height: imageProvider.image != null
                                      ? constraints.maxWidth
                                      : MediaQuery.of(context).size.height *
                                          0.5,
                                  child: CarouselViewTemplate(),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 15),
                      child: provider.grid_or_carousel
                          ? GridButtons()
                          : CarouselSizeButton(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: SaveButton(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
