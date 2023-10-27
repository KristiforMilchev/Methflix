import 'package:domain/models/app_config.dart';

abstract class IConfiguration {
  Future<AppConfig> getConfig();
  Future<bool> overrideConfig();
}
