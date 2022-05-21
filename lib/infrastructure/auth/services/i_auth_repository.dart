import 'package:dartz/dartz.dart';
import 'package:flutter_base/domain/auth/models/user.dart';
import 'package:flutter_base/infrastructure/core/failures/server_failures.dart';

abstract class IAuthDataRepository {
  Future<Either<ServiceFailure, User>> login({
    required String username,
    required String password,
  });

  Future<Either<ServiceFailure, Unit>> logout();

  Future<Either<ServiceFailure, User?>> getUserLoggedIn({
    required String sessionId,
  });
}
