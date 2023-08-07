import 'package:flutter/material.dart';
import 'package:gridapp/provider/carousel_provider.dart';
import 'package:gridapp/provider/grid_provider.dart';
import 'package:gridapp/screens/edit_screen.dart';
import 'package:provider/provider.dart';

class CarouselButton extends StatelessWidget {
  final String image;
  final int index;
  const CarouselButton({super.key, required this.image, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Image.asset(
        image,
        scale: 2.8,
      ),
      onTap: () {
        context.read<GridProvider>().GridCarousel(false);
        context
            .read<CarouselProvider>()
            .openCarouselPage(index, MediaQuery.of(context).size.width);
        
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => EditScreen()));
      },
    );
  }
}
