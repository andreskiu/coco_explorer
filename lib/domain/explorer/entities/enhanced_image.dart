import 'package:equatable/equatable.dart';

class EnhancedImage extends Equatable {
  final int id;
  final int width;
  final int height;
  final String flickrUrl;
  final String cocoUrl;
  final DateTime dateCreated;
  final DateTime dateCaptured;

  EnhancedImage({
    required this.id,
    required this.width,
    required this.height,
    required this.flickrUrl,
    required this.cocoUrl,
    required this.dateCreated,
    required this.dateCaptured,
  });

  @override
  List<Object?> get props => [
        id,
        width,
        height,
        flickrUrl,
        cocoUrl,
        dateCaptured.millisecondsSinceEpoch,
        dateCreated.millisecondsSinceEpoch
      ];

  EnhancedImage copyWith({
    int? id,
    int? width,
    int? height,
    String? flickrUrl,
    String? cocoUrl,
    DateTime? dateCreated,
    DateTime? dateCaptured,
  }) {
    return EnhancedImage(
      id: id ?? this.id,
      width: width ?? this.width,
      height: height ?? this.height,
      flickrUrl: flickrUrl ?? this.flickrUrl,
      cocoUrl: cocoUrl ?? this.cocoUrl,
      dateCreated: dateCreated ?? this.dateCreated,
      dateCaptured: dateCaptured ?? this.dateCaptured,
    );
  }
}
