import 'dart:math';

import 'package:flutter/material.dart';

import '../../domain/explorer/entities/figure.dart';

class FiguresPainter extends CustomPainter {
  final List<Figure> figures;
  final Size originalSize;
  FiguresPainter({
    required this.figures,
    required this.originalSize,
  });
  @override
  void paint(Canvas canvas, Size size) {
    figures.forEach((figure) {
      if (figure.points.isEmpty) {
        return;
      }
      final _random = Random();
      var r = (_random.nextDouble() * 255).floor();
      var g = (_random.nextDouble() * 255).floor();
      var b = (_random.nextDouble() * 255).floor();
      final _randomColor = Color.fromRGBO(r, g, b, 0.7);

      final _paint = Paint()..color = _randomColor;

      final _scaleFactorHorizontal = size.width / originalSize.width;
      final _scaleFactorVertical = size.height / originalSize.height;

      // ======== GENERATE COLORFULL PATH ========
      final _path = Path();
      final _points = [
        Offset(figure.initialPoint.x.toDouble() * _scaleFactorHorizontal,
            figure.initialPoint.y.toDouble() * _scaleFactorVertical)
      ];
      _points.addAll(figure.points.map(
        (point) => Offset(point.x.toDouble() * _scaleFactorHorizontal,
            point.y.toDouble() * _scaleFactorVertical),
      ));
      _path.addPolygon(_points, true);
      canvas.drawPath(_path, _paint);

      // ======== GENERATE BLACK PERIMETER LINE ========
      final _paint2 = Paint()
        ..color = Colors.black
        ..strokeWidth = 3;
      Point _lastPoint = figure.initialPoint;

      figure.points.forEach((point) {
        canvas.drawLine(
          Offset(
            _lastPoint.x.toDouble() * _scaleFactorHorizontal,
            _lastPoint.y.toDouble() * _scaleFactorVertical,
          ),
          Offset(
            point.x.toDouble() * _scaleFactorHorizontal,
            point.y.toDouble() * _scaleFactorVertical,
          ),
          _paint2,
        );
        _lastPoint = point;
      });

      // close de line
      canvas.drawLine(
        Offset(
          _lastPoint.x.toDouble() * _scaleFactorHorizontal,
          _lastPoint.y.toDouble() * _scaleFactorVertical,
        ),
        Offset(
          figure.initialPoint.x.toDouble() * _scaleFactorHorizontal,
          figure.initialPoint.y.toDouble() * _scaleFactorVertical,
        ),
        _paint2,
      );
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
