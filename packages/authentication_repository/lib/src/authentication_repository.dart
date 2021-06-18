import 'dart:async';
import 'dart:convert';

import 'package:authentication_repository/models/appointment.dart';
import 'package:authentication_repository/models/auth_response.dart';
import 'package:dio/dio.dart';
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

  Future<List<PatientAppointment>> getAppointmentForProfession(
      String profession) async {
    final response = await api.client.get<dynamic>(
      'AllVisitsProfession/{$profession}',
    );
    List<PatientAppointment> appointments = [];
    final lists = response.data;

    for (final appointment in lists) {
      for (final element in appointment) {
        int id = 0;
        DateTime startTime = DateTime.now();
        DateTime endTime = DateTime.now();
        String doctorName = '';
        if (element[0] is int) {
          id = element[0];
        }
        if (element[1] is String) {
          startTime = DateTime.parse(element[1]);
        }
        if (element[2] is String) {
          endTime = DateTime.parse(element[2]);
        }
        if (element[3] is String) {
          doctorName = element[3];
        }

        final parsedAppointment = PatientAppointment(
            id: id, start: startTime, end: endTime, doctorName: doctorName);

        appointments.add(parsedAppointment);
      }
    }

    return appointments;
  }
}
