import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_base/domain/core/failures.dart';
import 'package:flutter_base/domain/explorer/entities/enhanced_image.dart';
import 'package:flutter_base/domain/explorer/entities/keywords.dart';
import 'package:flutter_base/domain/explorer/interfaces/i_explorer_service.dart';

import '../datasources/remote_coco_datasource.dart';

@LazySingleton(as: IExplorerService)
class ExplorerServiceImpl extends IExplorerService {
  final RemoteCocoDataSource remote;

  ExplorerServiceImpl({
    required this.remote,
  });

  @override
  Future<Either<ErrorContent, List<EnhancedImage>>> getImages({
    required List<Keywords> keywords,
  }) {
    return remote.getImages(keywords: keywords);
  }

  @override
  Future<Either<ErrorContent, List<Keywords>>> getValidKeywords() {
    return remote.getValidKeywords();
  }
}
