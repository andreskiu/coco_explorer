import 'package:dartz/dartz.dart';
import 'package:flutter_base/domain/auth/failures/auth_failures.dart';
import 'package:flutter_base/domain/auth/services/auth_service.dart';
import 'package:flutter_base/domain/core/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LogoutUseCase extends UseCase<Unit, NoParams> {
  final AuthService service;

  LogoutUseCase(this.service);

  @override
  Future<Either<AuthFailure, Unit>> call(
    NoParams params,
  ) async {
    final result = await service.logout();

    return result.fold(
      (fail) => Left(AuthFailure.server(fail, AuthUseCases.Logout)),
      (_) => Right(_),
    );
  }
}
