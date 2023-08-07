import 'package:flutter/material.dart';
import 'package:gridapp/provider/grid_provider.dart';
import 'package:provider/provider.dart';

import 'grid_painter.dart';

class CustomPaintWidget extends StatelessWidget {
  final int rows;

  CustomPaintWidget({required this.rows});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: GridPainter(
        rows: rows,
        columns: 3,
      ),
      size: Size.infinite,
    );
  }
}
