// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i11;

import '../../application/explorer/explorer_state.dart' as _i16;
import '../../domain/explorer/interfaces/i_explorer_service.dart' as _i12;
import '../../domain/explorer/use_cases/get_images_use_case.dart' as _i14;
import '../../domain/explorer/use_cases/get_valid_keywords_use_case.dart'
    as _i15;
import '../../infrastructure/explorer/datasources/local_memory_datasource.dart'
    as _i9;
import '../../infrastructure/explorer/datasources/remote_coco_datasource.dart'
    as _i10;
import '../../infrastructure/explorer/service/explorer_service_impl.dart'
    as _i13;
import '../environments/environment_config.dart' as _i4;
import '../environments/environment_demo.dart' as _i6;
import '../environments/environment_dev.dart' as _i7;
import '../environments/environment_prod.dart' as _i8;
import '../environments/environment_qa.dart' as _i5;
import 'injectable.dart' as _i17;

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
  gh.lazySingleton<_i9.LocalMemoryExplorerDatasource>(
      () => _i9.LocalMemoryExplorerDatasource());
  gh.lazySingleton<_i10.RemoteCocoDataSource>(
      () => _i10.RemoteCocoDataSource(dio: get<_i3.Dio>()));
  await gh.factoryAsync<_i11.SharedPreferences>(() => registerModule.prefs,
      preResolve: true);
  gh.lazySingleton<_i12.IExplorerService>(() => _i13.ExplorerServiceImpl(
      remote: get<_i10.RemoteCocoDataSource>(),
      localMemory: get<_i9.LocalMemoryExplorerDatasource>()));
  gh.lazySingleton<_i14.GetImagesUseCase>(
      () => _i14.GetImagesUseCase(get<_i12.IExplorerService>()));
  gh.lazySingleton<_i15.GetValidKeywordsUseCase>(
      () => _i15.GetValidKeywordsUseCase(get<_i12.IExplorerService>()));
  gh.lazySingleton<_i16.ExplorerState>(() => _i16.ExplorerState(
      getImagesUseCase: get<_i14.GetImagesUseCase>(),
      getValidKeywordsUseCase: get<_i15.GetValidKeywordsUseCase>()));
  return get;
}

class _$RegisterModule extends _i17.RegisterModule {}
