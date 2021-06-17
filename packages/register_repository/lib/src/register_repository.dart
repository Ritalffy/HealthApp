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

  Future<List<String>> getProfessions() async {
    final response = await api.client.get<dynamic>(
      'professions',
    );
    List<String> professions = [];
    final lists = response.data;

    for (final profession in lists) {
      if (profession[0] is String) professions.add(profession[0]);
    }

    return professions;
  }

  void dispose() => _controller.close();
}
