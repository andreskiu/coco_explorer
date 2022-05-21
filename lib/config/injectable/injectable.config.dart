// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i10;

import '../../application/explorer/explorer_state.dart' as _i15;
import '../../domain/explorer/interfaces/i_explorer_service.dart' as _i11;
import '../../domain/explorer/use_cases/get_images_use_case.dart' as _i13;
import '../../domain/explorer/use_cases/get_valid_keywords_use_case.dart'
    as _i14;
import '../../infrastructure/explorer/datasources/remote_coco_datasource.dart'
    as _i9;
import '../../infrastructure/explorer/service/explorer_service_impl.dart'
    as _i12;
import '../environments/environment_config.dart' as _i4;
import '../environments/environment_demo.dart' as _i6;
import '../environments/environment_dev.dart' as _i7;
import '../environments/environment_prod.dart' as _i8;
import '../environments/environment_qa.dart' as _i5;
import 'injectable.dart' as _i16;

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
  gh.lazySingleton<_i3.Dio>(() => registerModule.dio());
  gh.factory<_i4.EnvironmentConfig>(() => _i5.EnvironmentTest(),
      registerFor: {_qa});
  gh.factory<_i4.EnvironmentConfig>(() => _i6.EnvironmentDemo(),
      registerFor: {_demo});
  gh.factory<_i4.EnvironmentConfig>(() => _i7.EnvironmentDev(),
      registerFor: {_dev});
  gh.factory<_i4.EnvironmentConfig>(() => _i8.EnvironmentProd(),
      registerFor: {_prod});
  gh.lazySingleton<_i9.RemoteCocoDataSource>(
      () => _i9.RemoteCocoDataSource(dio: get<_i3.Dio>()));
  await gh.factoryAsync<_i10.SharedPreferences>(() => registerModule.prefs,
      preResolve: true);
  gh.lazySingleton<_i11.IExplorerService>(
      () => _i12.ExplorerServiceImpl(remote: get<_i9.RemoteCocoDataSource>()));
  gh.lazySingleton<_i13.GetImagesUseCase>(
      () => _i13.GetImagesUseCase(get<_i11.IExplorerService>()));
  gh.lazySingleton<_i14.GetValidKeywordsUseCase>(
      () => _i14.GetValidKeywordsUseCase(get<_i11.IExplorerService>()));
  gh.lazySingleton<_i15.ExplorerState>(
      () => _i15.ExplorerState(getImagesUseCase: get<_i13.GetImagesUseCase>()));
  return get;
}

class _$RegisterModule extends _i16.RegisterModule {}
