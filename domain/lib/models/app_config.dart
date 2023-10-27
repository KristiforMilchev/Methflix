import 'dart:convert' show json;
import 'package:flutter/services.dart' show rootBundle;

class AppConfig {
  final String apiEndpoint;
  final String schema;
  final String ip;
  final int port;

  AppConfig({
    required this.apiEndpoint,
    required this.schema,
    required this.ip,
    required this.port,
  });

  factory AppConfig.fromJson(Map<String, dynamic> jsonMap) {
    return AppConfig(
      apiEndpoint: jsonMap['apiUrl'],
      schema: jsonMap['schema'],
      ip: jsonMap['ip'],
      port: jsonMap['port'],
    );
  }

  static Future<AppConfig> load() async {
    final String jsonString =
        await rootBundle.loadString('packages/domain/config.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    return AppConfig.fromJson(jsonMap);
  }
}
