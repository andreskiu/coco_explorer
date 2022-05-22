import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_base/domain/core/failures.dart';
import 'package:flutter_base/domain/explorer/entities/keywords.dart';
import 'package:flutter_base/domain/explorer/interfaces/i_explorer_service.dart';

import '../../../domain/explorer/entities/get_images_use_case_output.dart';
import '../datasources/local_memory_datasource.dart';
import '../datasources/remote_coco_datasource.dart';

@LazySingleton(as: IExplorerService)
class ExplorerServiceImpl extends IExplorerService {
  final RemoteCocoDataSource remote;
  final LocalMemoryExplorerDatasource localMemory;

  ExplorerServiceImpl({
    required this.remote,
    required this.localMemory,
  });

  @override
  Future<Either<ErrorContent, GetImagesUseCaseOutput>> getImages({
    required List<Keywords> keywords,
    required int initialSearchValue,
    required int finalSearchValue,
  }) {
    return remote.getImages(
      keywords: keywords,
      initialSearchValue: initialSearchValue,
      finalSearchValue: finalSearchValue,
    );
  }

  @override
  Future<Either<ErrorContent, List<Keywords>>> getValidKeywords() {
    return localMemory.getValidKeywords();
  }
}
