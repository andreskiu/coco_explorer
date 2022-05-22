import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:flutter_base/domain/core/failures.dart';
import 'package:flutter_base/domain/explorer/entities/enhanced_image.dart';
import 'package:flutter_base/domain/explorer/entities/keywords.dart';
import 'package:flutter_base/domain/explorer/interfaces/i_explorer_service.dart';
import 'package:flutter_base/infrastructure/explorer/models.dart/segment.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/explorer/entities/get_images_use_case_output.dart';

@lazySingleton
class RemoteCocoDataSource implements IExplorerService {
  final Dio dio;

  RemoteCocoDataSource({
    required this.dio,
  });

  @override
  Future<Either<ErrorContent, GetImagesUseCaseOutput>> getImages({
    required List<Keywords> keywords,
    int initialSearchValue = 0,
    int finalSearchValue = 10,
  }) async {
    try {
      //get images by keywords/category

      final _categoriesIds = keywords.map((keyword) => keyword.id).toList();
      final _responseWithImageIds =
          await dio.post('/coco-dataset-bigquery', data: {
        "category_ids": _categoriesIds,
        "querytype": "getImagesByCats",
      });
      if (_responseWithImageIds.statusCode != 200) {
        return Left(ErrorContent(message: 'Fail to get images'));
      }

      final _imagesToSearch = (_responseWithImageIds.data as List<dynamic>)
          .sublist(initialSearchValue, finalSearchValue);

      // 'getCaptions not needed
      final queryTypes = ["getImages", "getInstances"];
      final List<Future<Response<dynamic>>> _imageInfoFutures = [];

      for (int i = 0; i < 2; i++) {
        final _query = dio.post('/coco-dataset-bigquery', data: {
          "image_ids": _imagesToSearch,
          "querytype": queryTypes[i],
        });
        _imageInfoFutures.add(_query);
      }
      final _responses = await Future.wait(_imageInfoFutures);

      if (_responses[0].statusCode != 200 || _responses[1].statusCode != 200) {
        return Left(ErrorContent(message: 'Fail to get images or segments'));
      }

      final List<dynamic> _imageInfo = _responses[0].data;
      final List<dynamic> _segmentsInfo = _responses[1].data;
      final List<EnhancedImage> _images = _imagesToSearch.map(
        (imageId) {
          return EnhancedImage(
              id: imageId,
              width: 0,
              height: 0,
              flickrUrl: _imageInfo.firstWhere(
                (map) => map['id'] == imageId,
                orElse: () => null,
              )?['flickr_url'],
              cocoUrl: _imageInfo.firstWhere(
                (map) => map['id'] == imageId,
                orElse: () => null,
              )?['coco_url'],
              dateCreated: DateTime.now(),
              dateCaptured: DateTime.now(),
              figures: _segmentsInfo
                  .where((map) => map['image_id'] == imageId)
                  .map((info) {
                return Segment.fromMap(info).toFigure();
              }).toList());
        },
      ).toList();
      final _output = GetImagesUseCaseOutput(
        images: _images,
        initialIndex: initialSearchValue,
        finalIndex: finalSearchValue,
        totalImages: _responseWithImageIds.data.length,
      );
      return Right(_output);
    } catch (e) {
      print(e);
      return Left(ErrorContent(message: e.toString()));
    }
  }

  @override
  Future<Either<ErrorContent, List<Keywords>>> getValidKeywords() async {
    // TODO: implement getValidKeywords
    throw UnimplementedError();
  }
}
