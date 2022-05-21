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
    await Future.delayed(Duration(seconds: 2));
    final _keywords = [
      Keywords(id: 1, word: 'house'),
      Keywords(id: 2, word: 'sheep'),
      Keywords(id: 3, word: 'dog'),
      Keywords(id: 4, word: 'bike'),
      Keywords(id: 5, word: 'bus'),
      Keywords(id: 6, word: 'person'),
      Keywords(id: 7, word: 'radio'),
    ];
    return Right(_keywords);
  }
}
