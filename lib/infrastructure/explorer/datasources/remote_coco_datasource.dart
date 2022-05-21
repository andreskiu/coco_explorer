import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:flutter_base/domain/core/failures.dart';
import 'package:flutter_base/domain/explorer/entities/enhanced_image.dart';
import 'package:flutter_base/domain/explorer/entities/keywords.dart';
import 'package:flutter_base/domain/explorer/interfaces/i_explorer_service.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class RemoteCocoDataSource implements IExplorerService {
  final Dio dio;

  RemoteCocoDataSource({
    required this.dio,
  });

  @override
  Future<Either<ErrorContent, List<EnhancedImage>>> getImages({
    required List<Keywords> keywords,
  }) {
    // path base url + 'coco-dataset-bigquery'
    // TODO: implement getImages
    throw UnimplementedError();
  }

  @override
  Future<Either<ErrorContent, List<Keywords>>> getValidKeywords() async {
    // TODO: implement getKeywords
    throw UnimplementedError();
  }
}
