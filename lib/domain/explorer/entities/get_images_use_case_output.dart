import 'enhanced_image.dart';

class GetImagesUseCaseOutput {
  final List<EnhancedImage> images;
  final int initialIndex;
  final int finalIndex;
  final int totalImages;
  GetImagesUseCaseOutput({
    required this.images,
    required this.totalImages,
    required this.initialIndex,
    required this.finalIndex,
  });
}
