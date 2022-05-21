import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_base/domain/core/use_case.dart';
import 'package:flutter_base/domain/explorer/entities/enhanced_image.dart';
import 'package:flutter_base/domain/explorer/entities/keywords.dart';
import 'package:injectable/injectable.dart';

import '../../core/failures.dart';
import '../interfaces/i_explorer_service.dart';

@lazySingleton
class GetImagesUseCase
    extends UseCase<List<EnhancedImage>, GetImagesUseCaseParams> {
  final IExplorerService service;

  GetImagesUseCase(this.service);

  @override
  Future<Either<ErrorContent, List<EnhancedImage>>> call(
    GetImagesUseCaseParams params,
  ) async {
    final _error = params.areValid();
    if (_error != null) {
      return Left(_error);
    }

    final _servicesOrFailure = await service.getImages(
      keywords: params.keywords,
    );

    return _servicesOrFailure;
  }
}

class GetImagesUseCaseParams extends Equatable {
  final List<Keywords> keywords;

  GetImagesUseCaseParams({
    required this.keywords,
  });

  ErrorContent? areValid() {
    return null;
  }

  @override
  List<Object> get props => [keywords];
}
