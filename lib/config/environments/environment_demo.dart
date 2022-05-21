import 'package:injectable/injectable.dart';
import 'environment_config.dart';

@Environment(EnvironmentConfig.demo)
@Injectable(as: EnvironmentConfig)
class EnvironmentDemo extends EnvironmentConfig {
  @override
  String get baseUrl => 'https://us-central1-open-images-dataset.cloudfunctions.net/coco-dataset-bigquery';

  @override
  String get firebaseUrl => "use_with_local_data";

  @override
  String get environmentName => EnvironmentConfig.demo;
}
