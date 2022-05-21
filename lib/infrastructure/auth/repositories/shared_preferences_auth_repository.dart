import 'package:dartz/dartz.dart';
import 'package:flutter_base/domain/auth/models/session_information.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_base/infrastructure/auth/services/i_auth_storage_repository.dart';
import 'package:flutter_base/infrastructure/core/failures/server_failures.dart';

@LazySingleton(as: IAuthStorageRepository)
class SharedPreferencesAuthRepository extends IAuthStorageRepository {
  static const sessionIdKey = "sessionId";
  static const expirationDateKey = "expirationDate";
  static const usernameKey = "username";
  final SharedPreferences pref;
  SharedPreferencesAuthRepository({
    required this.pref,
  });
  @override
  Future<Either<ServiceFailure, SessionInformation>>
      getSessionInformation() async {
    final _sessionId = pref.getString(sessionIdKey) ?? "";
    final _expirationDate = DateTime.fromMillisecondsSinceEpoch(
        pref.getInt(expirationDateKey) ?? 0);

    return Right(
      SessionInformation(
        sessionId: _sessionId,
        expireSession: _expirationDate,
      ),
    );
  }

  @override
  Future<Either<ServiceFailure, Unit>> storeSessionInformation({
    required SessionInformation sessionInformation,
  }) async {
    pref.setInt(expirationDateKey,
        sessionInformation.expireSession.millisecondsSinceEpoch);
    pref.setString(sessionIdKey, sessionInformation.sessionId);

    return Right(unit);
  }

  @override
  Future<Either<ServiceFailure, Unit>> storeUsername({
    required String username,
  }) async {
    await pref.setString(usernameKey, username);
    return Right(unit);
  }

  @override
  Future<Either<ServiceFailure, String>> getUsername() async {
    final _username = pref.getString(usernameKey);
    if (_username == null) {
      return Right("a@a");
    }
    return Right(_username);
  }

  @override
  Future<void> clearAllStoredData() async {
    pref.remove(expirationDateKey);
    pref.remove(sessionIdKey);
  }
}
