import 'package:dartz/dartz.dart';
import 'package:flutter_base/domain/explorer/entities/keywords.dart';
import '../../core/failures.dart';
import '../entities/get_images_use_case_output.dart';

abstract class IExplorerService {
  Future<Either<ErrorContent, GetImagesUseCaseOutput>> getImages({
    required List<Keywords> keywords,
    required int initialSearchValue,
    required int finalSearchValue,
  });
  Future<Either<ErrorContent, List<Keywords>>> getValidKeywords();
}
