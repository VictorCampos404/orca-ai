import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:orca_ai/core/clients/app_client.dart';
import 'package:orca_ai/core/configs/api_config.dart';
import 'package:orca_ai/core/interceptors/interceptors.dart';

class GeminiClient extends AppClient {
  GeminiClient() {
    final baseOptions = BaseOptions(
      baseUrl: Modular.get<ApiConfig>().geminiBaseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 20),
      contentType: 'application/json',
    );
    super.client = Dio(baseOptions);
    super.client.interceptors.addAll([
      GeminiKeyInterceptor(key: Modular.get<ApiConfig>().geminiKey),
    ]);
  }
}
