import 'dart:convert';

import 'package:orca_ai/services/remote_config_service.dart';

class ApiConfig {
  final RemoteConfigService _remoteConfig;
  Map<String, dynamic> _json = {'': ''};

  ApiConfig(this._remoteConfig);

  Future<void> init() async {
    final apiConfig = await _remoteConfig.get('apiConfig');
    _json = jsonDecode(apiConfig.asString());
  }

  String get baseUrl => _json['baseUrl'] ?? '';
  String get geminiBaseUrl => _json['geminiBaseUrl'] ?? '';
  String get geminiKey => _json['geminiKey'] ?? '';
  String get apiKey => _json['apiKey'] ?? '';
}
