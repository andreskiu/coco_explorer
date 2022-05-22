import 'dart:convert';
import 'dart:math';

import 'package:equatable/equatable.dart';

import '../../../domain/explorer/entities/figure.dart';

class Segment extends Equatable {
  final List<double> segmentation;
  Segment({
    required this.segmentation,
  });

  Figure toFigure() {
    if (segmentation.isEmpty) {
      return Figure(initialPoint: Point(0, 0), points: []);
    }
    final _points = <Point>[];
    // extracted from renderSegms function in cocoexplorer.js file
    for (int m = 0; m < segmentation.length - 2; m += 2) {
      final _point = Point(segmentation[m + 2], segmentation[m + 3]);
      _points.add(_point);
    }
    return Figure(
      initialPoint: Point(segmentation[0], segmentation[1]),
      points: _points,
    );
  }

  @override
  List<Object?> get props => [segmentation];

  Map<String, dynamic> toMap() {
    return {
      'segmentation': segmentation,
    };
  }

  factory Segment.fromMap(Map<String, dynamic> map) {
    final _listNumbers = json.decode(map['segmentation']);
    try {
      return Segment(
        segmentation:
            _listNumbers[0] == null ? [] : List<double>.from(_listNumbers[0]),
      );
    } catch (e) {
      print(e);
      return Segment(segmentation: []);
    }
  }

  String toJson() => json.encode(toMap());

  factory Segment.fromJson(String source) =>
      Segment.fromMap(json.decode(source));
}
