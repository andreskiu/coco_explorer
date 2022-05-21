import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_base/domain/auth/failures/auth_failures.dart';
import 'package:flutter_base/domain/auth/services/auth_service.dart';
import 'package:flutter_base/domain/core/use_case.dart';

@lazySingleton
class GetUserRememberedUseCase extends UseCase<String, NoParams> {
  final AuthService service;

  GetUserRememberedUseCase(this.service);

  @override
  Future<Either<AuthFailure, String>> call(
    NoParams params,
  ) async {
    const useCase = AuthUseCases.getLoggedUser;
    final result = await service.getUsernameRemembered();

    return result.fold(
      (fail) => Left(AuthFailure.server(fail, AuthUseCases.getLoggedUser)),
      (username) {
        if (username.isEmpty) {
          return Left(
            AuthFailure.usecase(AuthUseCaseProblems.NotFound, useCase),
          );
        }
        return Right(username);
      },
    );
  }
}
