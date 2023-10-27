import 'dart:convert';

import 'package:application/implementations/local_storage.dart';
import 'package:domain/models/app_config.dart';
import 'package:infrastructure/interfaces/iconfiguration.dart';

class Configuration extends LocalStorage implements IConfiguration {
  @override
  Future<AppConfig> getConfig() async {
    var existingOverride = await get("Config") as String;
    if (existingOverride.isEmpty) {
      return await AppConfig.load();
    }

    var map = jsonDecode(existingOverride);
    return AppConfig.fromJson(map);
  }

  @override
  Future<bool> overrideConfig() {
    // TODO: implement overrideConfig
    throw UnimplementedError();
  }
}
