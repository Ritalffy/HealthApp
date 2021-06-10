import 'dart:async';
import 'dart:convert';

import 'package:health_api/health_api.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated, logout }

class AuthenticationRepository {
  final HealthApi api;
  final _controller = StreamController<AuthenticationStatus>();

  AuthenticationRepository({required this.api});

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> logIn({
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
    print(response.data);
  }

  void logOut() {
    api.removeAuthHeader();
    _controller.add(AuthenticationStatus.logout);
  }

  void dispose() => _controller.close();
}
