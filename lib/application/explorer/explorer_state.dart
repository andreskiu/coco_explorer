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
  List<Keywords> enteredKeywords = [];
  List<EnhancedImage> images = [];
  int totalImages = 0;
  int initialElement = 0;
  int finalElement = 10;
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

  Future<bool> getImages(
    List<Keywords> keywordsInputed,
    int initialElement,
    int finalElement,
  ) async {
    final _params = GetImagesUseCaseParams(
      keywords: keywordsInputed,
      initialSearchValue: initialElement,
      finalSearchValue: finalElement,
    );
    final _imagesInfoOrFailure = await getImagesUseCase.call(_params);
    _imagesInfoOrFailure.fold(
      (fail) {
        error = fail;
      },
      (imagesInfo) {
        images.addAll(imagesInfo.images);
        totalImages = imagesInfo.totalImages;
        error = null;
      },
    );
    notifyListeners();
    return _imagesInfoOrFailure.isRight();
  }
}
