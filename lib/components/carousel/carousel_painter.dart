import 'package:flutter/material.dart';

class CarouselPainter extends CustomPainter {
  final int columns;

  CarouselPainter({required this.columns});

  @override
  void paint(Canvas canvas, Size size) {
    double cellWidth = size.width / columns;
    //print(cellWidth);

    Paint paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    for (int i = 1; i < columns; i++) {
      double x = cellWidth * i;
      canvas.drawLine(Offset(x, 0), Offset(x, x / i), paint);
    }

    final borderPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    canvas.drawRect(
        Rect.fromLTWH(0, 0, cellWidth * columns, cellWidth), borderPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
