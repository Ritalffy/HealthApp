import 'package:dio/dio.dart';

class HealthApiClient {
  final Dio _client;
  static const authorizationHeader = 'Authorization';
  dynamic setAuthHeader(
      RequestOptions options, RequestInterceptorHandler handler) {
    // TODO: get current token
    final token = null;

    options.headers[authorizationHeader] = token;
    print('REQUEST[${options.method}] => PATH: ${options.path}');
    return options;
  }

  HealthApiClient({
    required Uri url,
    required Map<String, String> defaultHeaders,
  }) : _client = Dio(
          BaseOptions(
            baseUrl: url.toString(),
            connectTimeout: 5000,
            receiveTimeout: 5000,
            headers: defaultHeaders,
            contentType: 'application/json',
          ),
        ) {
    _client.interceptors.add(InterceptorsWrapper(onRequest: setAuthHeader));
  }
}
