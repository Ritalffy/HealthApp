import 'package:dio/dio.dart';

class HealthApi {
  final Dio client;
  static const authorizationHeader = 'Authorization';
  RequestOptions setAuthHeader(
      RequestOptions options, RequestInterceptorHandler handler) {
    // TODO: get current token
    final token = null;
    options.headers[authorizationHeader] = token;
    print('REQUEST[${options.method}] => PATH: ${options.path}');
    return options;
  }

  void removeAuthHeader() {
    client.options.headers[authorizationHeader] = null;
  }

  HealthApi({
    required String url,
    Map<String, String>? defaultHeaders,
  }) : client = Dio(
          BaseOptions(
            baseUrl: url.toString(),
            connectTimeout: 1000,
            receiveTimeout: 1000,
            headers: defaultHeaders,
            contentType: 'application/json',
          ),
        ) {
    // client.interceptors.add(InterceptorsWrapper(onRequest: setAuthHeader));
  }
}
