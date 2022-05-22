import 'package:flutter_base/domain/explorer/entities/keywords.dart';
import 'package:flutter_base/domain/core/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_base/domain/explorer/interfaces/i_explorer_service.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/explorer/entities/get_images_use_case_output.dart';

@lazySingleton
class LocalMemoryExplorerDatasource implements IExplorerService {
  @override
  Future<Either<ErrorContent, GetImagesUseCaseOutput>> getImages({
    required List<Keywords> keywords,
    required int initialSearchValue,
    required int finalSearchValue,
  }) {
    // TODO: implement getImages
    throw UnimplementedError();
  }

  @override
  Future<Either<ErrorContent, List<Keywords>>> getValidKeywords() async {
    // This data is hardcoded in coco explorer page. File cocoexplorer.js
    final _keywords = [
      Keywords(id: 1, word: 'person'),
      Keywords(id: 2, word: 'bicycle'),
      Keywords(id: 3, word: 'car'),
      Keywords(id: 4, word: 'motorcycle'),
      Keywords(id: 5, word: 'airplane'),
      Keywords(id: 6, word: 'bus'),
      Keywords(id: 7, word: 'train'),
      Keywords(id: 8, word: 'truck'),
      Keywords(id: 9, word: 'boat'),
      Keywords(id: 10, word: 'traffic light'),
      Keywords(id: 11, word: 'fire hydrant'),
      Keywords(id: 13, word: 'stop sign'),
      Keywords(id: 14, word: 'parking meter'),
      Keywords(id: 15, word: 'bench'),
      Keywords(id: 16, word: 'bird'),
      Keywords(id: 17, word: 'cat'),
      Keywords(id: 18, word: 'dog'),
      Keywords(id: 19, word: 'horse'),
      Keywords(id: 20, word: 'sheep'),
      Keywords(id: 21, word: 'cow'),
      Keywords(id: 22, word: 'elephant'),
      Keywords(id: 23, word: 'bear'),
      Keywords(id: 24, word: 'zebra'),
      Keywords(id: 25, word: 'giraffe'),
      Keywords(id: 27, word: 'backpack'),
      Keywords(id: 28, word: 'umbrella'),
      Keywords(id: 31, word: 'handbag'),
      Keywords(id: 32, word: 'tie'),
      Keywords(id: 33, word: 'suitcase'),
      Keywords(id: 34, word: 'frisbee'),
      Keywords(id: 35, word: 'skis'),
      Keywords(id: 36, word: 'snowboard'),
      Keywords(id: 37, word: 'sports ball'),
      Keywords(id: 38, word: 'kite'),
      Keywords(id: 39, word: 'baseball bat'),
      Keywords(id: 40, word: 'baseball glove'),
      Keywords(id: 41, word: 'skateboard'),
      Keywords(id: 42, word: 'surfboard'),
      Keywords(id: 43, word: 'tennis racket'),
      Keywords(id: 44, word: 'bottle'),
      Keywords(id: 46, word: 'wine glass'),
      Keywords(id: 47, word: 'cup'),
      Keywords(id: 48, word: 'fork'),
      Keywords(id: 49, word: 'knife'),
      Keywords(id: 50, word: 'spoon'),
      Keywords(id: 51, word: 'bowl'),
      Keywords(id: 52, word: 'banana'),
      Keywords(id: 53, word: 'apple'),
      Keywords(id: 54, word: 'sandwich'),
      Keywords(id: 55, word: 'orange'),
      Keywords(id: 56, word: 'broccoli'),
      Keywords(id: 57, word: 'carrot'),
      Keywords(id: 58, word: 'hot dog'),
      Keywords(id: 59, word: 'pizza'),
      Keywords(id: 60, word: 'donut'),
      Keywords(id: 61, word: 'cake'),
      Keywords(id: 62, word: 'chair'),
      Keywords(id: 63, word: 'couch'),
      Keywords(id: 64, word: 'potted plant'),
      Keywords(id: 65, word: 'bed'),
      Keywords(id: 67, word: 'dining table'),
      Keywords(id: 70, word: 'toilet'),
      Keywords(id: 72, word: 'tv'),
      Keywords(id: 73, word: 'laptop'),
      Keywords(id: 74, word: 'mouse'),
      Keywords(id: 75, word: 'remote'),
      Keywords(id: 76, word: 'keyboard'),
      Keywords(id: 77, word: 'cell phone'),
      Keywords(id: 78, word: 'microwave'),
      Keywords(id: 79, word: 'oven'),
      Keywords(id: 80, word: 'toaster'),
      Keywords(id: 81, word: 'sink'),
      Keywords(id: 82, word: 'refrigerator'),
      Keywords(id: 84, word: 'book'),
      Keywords(id: 85, word: 'clock'),
      Keywords(id: 86, word: 'vase'),
      Keywords(id: 87, word: 'scissors'),
      Keywords(id: 88, word: 'teddy bear'),
      Keywords(id: 89, word: 'hair drier'),
      Keywords(id: 90, word: 'toothbrush'),
    ];
    return Right(_keywords);
  }
}
