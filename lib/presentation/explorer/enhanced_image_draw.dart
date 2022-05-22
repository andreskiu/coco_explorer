import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_base/domain/explorer/entities/enhanced_image.dart';

import '../core/responsivity/responsive_calculations.dart';
import 'figures_paint.dart';

class EnhancedImageDraw extends StatelessWidget {
  const EnhancedImageDraw({
    Key? key,
    required this.image,
  }) : super(key: key);

  final EnhancedImage image;

  // Required to get original image size and calculate segments properly
  Future<ImageInfo> getImageInfo(Image img) async {
    final c = new Completer<ImageInfo>();
    img.image
        .resolve(new ImageConfiguration())
        .addListener(new ImageStreamListener((ImageInfo i, bool _) {
      c.complete(i);
    }));
    return c.future;
  }

  @override
  Widget build(BuildContext context) {
    // it ca be improved with cached_network_Image
    Image _image = Image.network(image.cocoUrl);
    return FutureBuilder<ImageInfo>(
        future: getImageInfo(_image),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text('Loading image information'),
            );
          }
          final _imageInfo = snapshot.data;
          final _originalSize = Size(
            _imageInfo?.image.width.toDouble() ?? 0,
            _imageInfo?.image.height.toDouble() ?? 0,
          );
          return Container(
            margin: EdgeInsets.only(top: 2 * Info.verticalUnit),
            width: Info.horizontalUnit * 90,
            child: CustomPaint(
              foregroundPainter: FiguresPainter(
                figures: image.figures,
                originalSize: _originalSize,
              ),
              child: _image,
            ),
          );
        });
  }
}
