import 'package:dartz/dartz.dart';
import 'package:flutter_base/domain/explorer/entities/enhanced_image.dart';
import 'package:flutter_base/domain/explorer/entities/keywords.dart';
import '../../core/failures.dart';

abstract class IExplorerService {
  Future<Either<ErrorContent, List<EnhancedImage>>> getImages({
    required List<Keywords> keywords,
  });
  Future<Either<ErrorContent, List<Keywords>>> getValidKeywords();
}
