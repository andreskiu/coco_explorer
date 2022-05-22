import 'dart:math';

import 'package:equatable/equatable.dart';

class Figure extends Equatable {
  final Point initialPoint;
  final List<Point> points;
  Figure({
    required this.initialPoint,
    required this.points,
  });

  @override
  List<Object?> get props => [initialPoint, points];
}
