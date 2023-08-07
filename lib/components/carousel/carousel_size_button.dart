import 'package:amplitude_flutter/amplitude.dart';
import 'package:flutter/material.dart';
import 'package:gridapp/components/amplitude/amplitude.dart';
import 'package:gridapp/provider/carousel_provider.dart';
import 'package:provider/provider.dart';

class CarouselSizeButton extends StatelessWidget {
  const CarouselSizeButton({super.key});

  @override
  Widget build(BuildContext context) {
    var maxFinalsize = context.watch<CarouselProvider>().maxFinalSize;
    var minFinalsize = context.watch<CarouselProvider>().minFinalSize;
    var carouselProvider = context.watch<CarouselProvider>();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Text(
            "Carousel Size",
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.07,
          width: MediaQuery.of(context).size.width * 0.4,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              border: Border.all(width: 1.5, color: Colors.white),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () async {
                  context.read<CarouselProvider>().minusCarouselSize();
                  context
                      .read<CarouselProvider>()
                      .calculateHeight(MediaQuery.of(context).size.width);
                  await AmplitudeConnection.carousel_option_changed(
                      carouselProvider.carouselSize.toString());
                },
                child: Icon(
                  Icons.remove,
                  color: minFinalsize ? Colors.grey : Colors.white,
                  size: MediaQuery.of(context).size.height * 0.04,
                ),
              ),
              Consumer<CarouselProvider>(
                builder: (context, prov, child) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Container(
                      child: Text(
                        context
                            .watch<CarouselProvider>()
                            .carouselSize
                            .toString(),
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ),
                  );
                },
              ),
              GestureDetector(
                onTap: () async {
                  context.read<CarouselProvider>().plusCarouselTemplate();
                  context
                      .read<CarouselProvider>()
                      .calculateHeight(MediaQuery.of(context).size.width);
                  await AmplitudeConnection.carousel_option_changed(
                      carouselProvider.carouselSize.toString());
                },
                child: Icon(
                  Icons.add,
                  color: maxFinalsize ? Colors.grey : Colors.white,
                  size: MediaQuery.of(context).size.height * 0.04,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
