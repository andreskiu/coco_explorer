// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i12;

import '../../application/auth/auth_state.dart' as _i3;
import '../../application/auth/login_page_state.dart' as _i21;
import '../../domain/auth/services/auth_service.dart' as _i15;
import '../../domain/auth/use_cases/get_user_logged_in.dart' as _i17;
import '../../domain/auth/use_cases/get_user_remembered.dart' as _i18;
import '../../domain/auth/use_cases/login.dart' as _i19;
import '../../domain/auth/use_cases/logout.dart' as _i20;
import '../../infrastructure/auth/repositories/demo_auth_repository.dart'
    as _i11;
import '../../infrastructure/auth/repositories/shared_preferences_auth_repository.dart'
    as _i14;
import '../../infrastructure/auth/services/auth_service.dart' as _i16;
import '../../infrastructure/auth/services/i_auth_repository.dart' as _i10;
import '../../infrastructure/auth/services/i_auth_storage_repository.dart'
    as _i13;
import '../environments/environment_config.dart' as _i5;
import '../environments/environment_demo.dart' as _i7;
import '../environments/environment_dev.dart' as _i8;
import '../environments/environment_prod.dart' as _i9;
import '../environments/environment_qa.dart' as _i6;
import 'injectable.dart' as _i22;

const String _qa = 'qa';
const String _demo = 'demo';
const String _dev = 'dev';
const String _prod = 'prod';
// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.singletonAsync<_i3.AuthState>(() => _i3.AuthState.init());
  gh.lazySingleton<_i4.Dio>(() => registerModule.dio());
  gh.factory<_i5.EnvironmentConfig>(() => _i6.EnvironmentTest(),
      registerFor: {_qa});
  gh.factory<_i5.EnvironmentConfig>(() => _i7.EnvironmentDemo(),
      registerFor: {_demo});
  gh.factory<_i5.EnvironmentConfig>(() => _i8.EnvironmentDev(),
      registerFor: {_dev});
  gh.factory<_i5.EnvironmentConfig>(() => _i9.EnvironmentProd(),
      registerFor: {_prod});
  gh.lazySingleton<_i10.IAuthDataRepository>(() => _i11.DemoRepository(),
      registerFor: {_demo});
  await gh.factoryAsync<_i12.SharedPreferences>(() => registerModule.prefs,
      preResolve: true);
  gh.lazySingleton<_i13.IAuthStorageRepository>(() =>
      _i14.SharedPreferencesAuthRepository(
          pref: get<_i12.SharedPreferences>()));
  gh.lazySingleton<_i15.AuthService>(() => _i16.AuthServiceImpl(
      repository: get<_i10.IAuthDataRepository>(),
      localStorage: get<_i13.IAuthStorageRepository>()));
  gh.lazySingleton<_i17.GetUserLoggedInUseCase>(
      () => _i17.GetUserLoggedInUseCase(get<_i15.AuthService>()));
  gh.lazySingleton<_i18.GetUserRememberedUseCase>(
      () => _i18.GetUserRememberedUseCase(get<_i15.AuthService>()));
  gh.lazySingleton<_i19.LoginUseCase>(
      () => _i19.LoginUseCase(get<_i15.AuthService>()));
  gh.lazySingleton<_i20.LogoutUseCase>(
      () => _i20.LogoutUseCase(get<_i15.AuthService>()));
  gh.factoryAsync<_i21.LoginPageState>(() async => _i21.LoginPageState(
      loginUseCase: get<_i19.LoginUseCase>(),
      authState: await get.getAsync<_i3.AuthState>(),
      getUserRememberedUseCase: get<_i18.GetUserRememberedUseCase>()));
  return get;
}

class _$RegisterModule extends _i22.RegisterModule {}
