import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_base/domain/auth/failures/auth_failures.dart';
import 'package:flutter_base/domain/auth/fields/password_field.dart';
import 'package:flutter_base/domain/auth/models/user.dart';
import 'package:flutter_base/domain/auth/services/auth_service.dart';
import 'package:flutter_base/domain/core/core_fields/email_field.dart';
import 'package:flutter_base/domain/core/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LoginUseCase extends UseCase<User, LoginParams> {
  final AuthService service;

  LoginUseCase(this.service);

  @override
  Future<Either<AuthFailure, User>> call(
    LoginParams params,
  ) async {
    if (!params.areValid()) {
      return Left(
        AuthFailure.usecase(
          AuthUseCaseProblems.InvalidParams,
          AuthUseCases.Login,
        ),
      );
    }

    final result = await service.login(
      username: params.email.getValue()!,
      password: params.password.getValue()!,
      rememberUsername: params.rememberUsername,
    );

    return result.fold(
      (fail) {
        return Left(AuthFailure.server(fail, AuthUseCases.Login));
      },
      (user) {
        return Right(user);
      },
    );
  }
}

class LoginParams extends Equatable {
  final EmailField email;
  final PasswordField password;
  final bool rememberUsername;

  LoginParams({
    required this.email,
    required this.password,
    required this.rememberUsername,
  });

  bool areValid() {
    final _psw = PasswordField(password.value.getOrElse(() => ""),
        validateSecurity: false);
    return email.isValid() && _psw.isValid();
  }

  @override
  List<Object> get props => [email];
}
