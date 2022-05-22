import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_base/domain/core/use_case.dart';
import 'package:flutter_base/domain/explorer/entities/keywords.dart';

import '../../core/failures.dart';
import '../entities/get_images_use_case_output.dart';
import '../interfaces/i_explorer_service.dart';

@lazySingleton
class GetImagesUseCase
    extends UseCase<GetImagesUseCaseOutput, GetImagesUseCaseParams> {
  final IExplorerService service;

  GetImagesUseCase(this.service);

  @override
  Future<Either<ErrorContent, GetImagesUseCaseOutput>> call(
    GetImagesUseCaseParams params,
  ) async {
    final _error = params.areValid();
    if (_error != null) {
      return Left(_error);
    }

    final _servicesOrFailure = await service.getImages(
      keywords: params.keywords,
      initialSearchValue: params.initialSearchValue,
      finalSearchValue: params.finalSearchValue,
    );

    return _servicesOrFailure;
  }
}

class GetImagesUseCaseParams extends Equatable {
  final List<Keywords> keywords;
  final int initialSearchValue;
  final int finalSearchValue;

  GetImagesUseCaseParams({
    required this.keywords,
    required this.initialSearchValue,
    required this.finalSearchValue,
  });

  ErrorContent? areValid() {
    String _msg = '';
    if (initialSearchValue < 0) {
      _msg = 'Invalid initial value';
    }
    if (initialSearchValue > finalSearchValue) {
      _msg = 'Final value can\'t be greater than initial value';
    }
    if (_msg.isNotEmpty) {
      return ErrorContent(message: _msg);
    }
    return null;
  }

  @override
  List<Object> get props => [keywords];
}
