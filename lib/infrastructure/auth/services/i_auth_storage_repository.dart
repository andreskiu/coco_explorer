import 'package:dartz/dartz.dart';
import 'package:flutter_base/domain/auth/models/session_information.dart';
import 'package:flutter_base/infrastructure/core/failures/server_failures.dart';
import 'package:flutter_base/infrastructure/core/interfaces/i_local_storage_repository.dart';

abstract class IAuthStorageRepository implements ILocalStorageRepository {
  Future<Either<ServiceFailure, Unit>> storeSessionInformation({
    required SessionInformation sessionInformation,
  });

  Future<Either<ServiceFailure, SessionInformation>> getSessionInformation();
  Future<Either<ServiceFailure, Unit>> storeUsername({
    required String username,
  });

  Future<Either<ServiceFailure, String>> getUsername();
}
