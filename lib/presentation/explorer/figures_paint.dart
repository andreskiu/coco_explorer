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
      final _randomColor = Color.fromRGBO(r, g, b, 1);
      final _paint = Paint()
        ..color = _randomColor
        ..strokeWidth = 3;
      final _scaleFactorHorizontal = size.width / originalSize.width;
      final _scaleFactorVertical = size.height / originalSize.height;

      // canvas.translate(
      //   figure.initialPoint.x.toDouble() * _scaleFactorHorizontal,
      //   figure.initialPoint.y.toDouble() * _scaleFactorVertical,
      // );

      Point _lastPoint = figure.initialPoint;
      figure.points.forEach((point) {
        canvas.drawLine(
          Offset(_lastPoint.x.toDouble() * _scaleFactorHorizontal,
              _lastPoint.y.toDouble() * _scaleFactorVertical),
          Offset(point.x.toDouble() * _scaleFactorHorizontal,
              point.y.toDouble() * _scaleFactorVertical),
          _paint,
        );
        _lastPoint = point;
      });

      // close de path
      canvas.drawLine(
        Offset(_lastPoint.x.toDouble() * _scaleFactorHorizontal,
            _lastPoint.y.toDouble() * _scaleFactorVertical),
        Offset(figure.initialPoint.x.toDouble() * _scaleFactorHorizontal,
            figure.initialPoint.y.toDouble() * _scaleFactorVertical),
        _paint,
      );
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
