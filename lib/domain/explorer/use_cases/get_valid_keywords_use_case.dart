import 'package:dartz/dartz.dart';
import 'package:flutter_base/domain/core/use_case.dart';
import 'package:flutter_base/domain/explorer/entities/keywords.dart';
import 'package:injectable/injectable.dart';

import '../../core/failures.dart';
import '../interfaces/i_explorer_service.dart';

@lazySingleton
class GetValidKeywordsUseCase extends UseCase<List<Keywords>, NoParams> {
  final IExplorerService service;

  GetValidKeywordsUseCase(this.service);

  @override
  Future<Either<ErrorContent, List<Keywords>>> call(
    NoParams params,
  ) async {
    // final _error = params.areValid();
    // if (_error != null) {
    //   return Left(_error);
    // }

    final _servicesOrFailure = await service.getValidKeywords();

    return _servicesOrFailure;
  }
}

// class GetValidKeywordsUseCaseParams extends Equatable {
//   final List<Keywords> keywords;

//   GetValidKeywordsUseCaseParams({
//     required this.keywords,
//   });

//   ErrorContent? areValid() {
//     return null;
//   }

//   @override
//   List<Object> get props => [keywords];
// }
