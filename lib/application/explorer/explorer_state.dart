import 'package:flutter/foundation.dart';
import 'package:flutter_base/domain/core/failures.dart';
import 'package:flutter_base/domain/core/use_case.dart';
import 'package:flutter_base/domain/explorer/entities/enhanced_image.dart';
import 'package:flutter_base/domain/explorer/entities/keywords.dart';
import 'package:injectable/injectable.dart';

import '../../domain/explorer/use_cases/get_images_use_case.dart';
import '../../domain/explorer/use_cases/get_valid_keywords_use_case.dart';

@lazySingleton
class ExplorerState extends ChangeNotifier {
  final GetImagesUseCase getImagesUseCase;
  final GetValidKeywordsUseCase getValidKeywordsUseCase;

  ExplorerState({
    required this.getImagesUseCase,
    required this.getValidKeywordsUseCase,
  });

  ErrorContent? error;
  List<Keywords> keywords = [];
  List<EnhancedImage> images = [];
  bool isLoadingKeywords = false;

  Future<bool> getValidKeywords() async {
    isLoadingKeywords = true;
    notifyListeners();
    final _keyWordsOrFailure = await getValidKeywordsUseCase.call(NoParams());
    _keyWordsOrFailure.fold(
      (fail) {
        error = fail;
      },
      (words) {
        keywords = words;
        error = null;
      },
    );
    isLoadingKeywords = false;
    notifyListeners();
    return _keyWordsOrFailure.isRight();
  }

  Future<bool> getImages(List<Keywords> keywordsInputed) async {
    final _params = GetImagesUseCaseParams(keywords: keywordsInputed);
    final _imagesOrFailure = await getImagesUseCase.call(_params);
    _imagesOrFailure.fold(
      (fail) {
        error = fail;
      },
      (enhancedImages) {
        images = enhancedImages;
        error = null;
      },
    );
    notifyListeners();
    return _imagesOrFailure.isRight();
  }
}
