import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:health_api/health_api.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated, logout }

class AuthResponse {
  final String token;
  final String role;
  AuthResponse({
    required this.token,
    required this.role,
  });
}

class AuthenticationRepository {
  final HealthApi api;
  final _controller = StreamController<AuthenticationStatus>();

  AuthenticationRepository({required this.api});

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<AuthResponse> logIn({
    required String email,
    required String password,
  }) async {
    final response = await api.client.post<dynamic>(
      'authenticate',
      data: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    return AuthResponse(
      token: response.data['access_token'],
      role: response.data['role'],
    );
  }

  void setToken(String token) {
    api.client.interceptors.add(InterceptorsWrapper(onRequest: (
      RequestOptions options,
      RequestInterceptorHandler handler,
    ) {
      options.headers['token'] = token;
    }));
  }

  void logOut() {
    api.removeAuthHeader();
    _controller.add(AuthenticationStatus.logout);
  }

  void dispose() => _controller.close();
}
