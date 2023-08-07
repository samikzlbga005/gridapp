import 'package:flutter/material.dart';

import 'carousel_painter.dart';

class CustomCarouselPaintWidget extends StatelessWidget {
  final int columns;

  CustomCarouselPaintWidget({required this.columns,});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CarouselPainter(columns: columns),
      size: Size.infinite,
    );
  }
}
