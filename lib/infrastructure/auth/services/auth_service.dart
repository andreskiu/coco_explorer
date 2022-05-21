import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_base/domain/auth/models/user.dart';
import 'package:flutter_base/domain/auth/services/auth_service.dart';
import 'package:flutter_base/infrastructure/core/failures/server_failures.dart';

import 'auth_error_codes.dart';
import 'i_auth_repository.dart';
import 'i_auth_storage_repository.dart';

@LazySingleton(as: AuthService)
class AuthServiceImpl extends AuthService {
  final IAuthDataRepository repository;
  final IAuthStorageRepository localStorage;

  AuthServiceImpl({
    required this.repository,
    required this.localStorage,
  });

  @override
  Future<Either<ServiceFailure, User>> login({
    required String username,
    required String password,
    required bool rememberUsername,
  }) async {
    final _userOrFailure = await repository.login(
      username: username,
      password: password,
    );

    _userOrFailure.fold(
      (l) => null,
      (user) {
        localStorage.storeSessionInformation(sessionInformation: user.session!);
        if (rememberUsername) {
          localStorage.storeUsername(username: username);
        } else {
          //clear username
          localStorage.storeUsername(username: "");
        }
      },
    );
    return _userOrFailure;
  }

  @override
  Future<Either<ServiceFailure, User?>> getUserLoggedIn() async {
    final _sessionInfoOrFailure = await localStorage.getSessionInformation();

    return _sessionInfoOrFailure.fold(
      (fail) {
        return Left(ServiceFailure(
          type: ServiceFailureType.FeatureFailure,
          errorCode: fail.errorCode,
        ));
      },
      (session) {
        if (session.expireSession.isAfter(DateTime.now())) {
          return Left(ServiceFailure(
            type: ServiceFailureType.FeatureFailure,
            errorCode: AuthErrorCodes.sessionExpired,
          ));
        }

        return repository.getUserLoggedIn(sessionId: session.sessionId);
      },
    );
  }

  @override
  Future<Either<ServiceFailure, Unit>> logout() async {
    await localStorage.clearAllStoredData();
    return repository.logout();
  }

  @override
  Future<Either<ServiceFailure, String>> getUsernameRemembered() async {
    return localStorage.getUsername();
  }
}
