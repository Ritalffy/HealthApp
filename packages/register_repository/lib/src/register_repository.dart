import 'dart:async';
import 'dart:convert';

import 'package:health_api/health_api.dart';

enum RegisterStatus {
  unknown,
  registered,
}

class RegisterRepository {
  final HealthApi api;
  final _controller = StreamController<RegisterStatus>();
  RegisterRepository({required this.api});
  Stream<RegisterStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield RegisterStatus.unknown;
    yield* _controller.stream;
  }

  Future<void> register({
    required String email,
    required String password,
    required String role,
    String? profession,
  }) async {
    await api.client.post<dynamic>(
      'user',
      data: jsonEncode(<String, String>{
        'email': email,
        'password': password,
        'role': role,
        'profession': profession ?? ' ',
      }),
    );
  }

  void dispose() => _controller.close();
}
