import 'package:dartz/dartz.dart';
import 'package:flutter_base/domain/auth/failures/auth_failures.dart';
import 'package:flutter_base/domain/auth/models/user.dart';
import 'package:flutter_base/domain/auth/services/auth_service.dart';
import 'package:flutter_base/domain/core/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetUserLoggedInUseCase extends UseCase<User, NoParams> {
  final AuthService service;

  GetUserLoggedInUseCase(this.service);

  @override
  Future<Either<AuthFailure, User>> call(
    NoParams params,
  ) async {
    const useCase = AuthUseCases.getLoggedUser;
    final result = await service.getUserLoggedIn();

    return result.fold(
      (fail) => Left(AuthFailure.server(fail, AuthUseCases.getLoggedUser)),
      (user) {
        if (user == null) {
          return Left(
            AuthFailure.usecase(AuthUseCaseProblems.NotFound, useCase),
          );
        }
        return Right(user);
      },
    );
  }
}
