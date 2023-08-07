import 'package:flutter/material.dart';

class GridPainter extends CustomPainter {
  final int rows;
  final int columns;
  final Paint _paint = Paint()
    ..color = Colors.black
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3.0;

  GridPainter({required this.rows, required this.columns});

  @override
  void paint(Canvas canvas, Size size) {
    double cellSize = size.width / columns;
    // print(" cell size: ${cellSize * 3}");
    //print("size.with : ${size.width}");
    double height = cellSize * rows;
    double width = cellSize * 3;
    // Draw the inner grid
    for (int i = 1; i < columns; i++) {
      double dx = cellSize * i;
      canvas.drawLine(Offset(dx, 0), Offset(dx, height), _paint);
    }
    for (int i = 1; i < rows; i++) {
      double dy = cellSize * i;
      //print(dy);
      canvas.drawLine(Offset(0, dy), Offset(size.width, dy), _paint);
    }

    // Draw the outer border
    final borderPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, height), borderPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
