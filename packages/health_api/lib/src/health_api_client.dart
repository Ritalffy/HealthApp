import 'package:dio/dio.dart';

class HealthApi {
  final Dio client;
  static const authorizationHeader = 'Authorization';

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
        );
}
