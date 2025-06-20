import 'package:dio/dio.dart';

class GeminiKeyInterceptor extends Interceptor {
  final String key;

  GeminiKeyInterceptor({required this.key});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (key.isNotEmpty) {
      options.queryParameters.addAll({'key': key});
    }

    super.onRequest(options, handler);
  }
}
