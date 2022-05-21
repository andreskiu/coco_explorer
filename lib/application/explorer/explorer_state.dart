import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../domain/explorer/use_cases/get_images_use_case.dart';

@lazySingleton
class ExplorerState extends ChangeNotifier {
  final GetImagesUseCase getImagesUseCase;

  ExplorerState({
    required this.getImagesUseCase,
  });
}
