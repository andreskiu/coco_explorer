import 'package:equatable/equatable.dart';

class EnhancedImage extends Equatable {
  final int id;
  final int width;
  final int height;
  final String fileName;
  final String url;
  final String flickrUrl;
  final String cocoUrl;
  final DateTime dateCreated;
  final DateTime dateCaptured;

  EnhancedImage({
    required this.id,
    required this.width,
    required this.height,
    required this.fileName,
    required this.url,
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
        fileName,
        url,
        flickrUrl,
        cocoUrl,
        dateCaptured.millisecondsSinceEpoch,
        dateCreated.millisecondsSinceEpoch
      ];

  EnhancedImage copyWith({
    int? id,
    int? width,
    int? height,
    String? fileName,
    String? url,
    String? flickrUrl,
    String? cocoUrl,
    DateTime? dateCreated,
    DateTime? dateCaptured,
  }) {
    return EnhancedImage(
      id: id ?? this.id,
      width: width ?? this.width,
      height: height ?? this.height,
      fileName: fileName ?? this.fileName,
      url: url ?? this.url,
      flickrUrl: flickrUrl ?? this.flickrUrl,
      cocoUrl: cocoUrl ?? this.cocoUrl,
      dateCreated: dateCreated ?? this.dateCreated,
      dateCaptured: dateCaptured ?? this.dateCaptured,
    );
  }
}
