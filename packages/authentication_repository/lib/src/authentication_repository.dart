import 'dart:async';
import 'dart:convert';

import 'package:authentication_repository/models/appointment.dart';
import 'package:authentication_repository/models/auth_response.dart';
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

  // void setToken(String token) {
  //   api.client.interceptors.add(InterceptorsWrapper(onRequest: (
  //     RequestOptions options,
  //     RequestInterceptorHandler handler,
  //   ) {
  //     options.headers['token'] = token;
  //   }));
  // }

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
    String profession,
  ) async {
    print(profession);
    final response = await api.client.get<dynamic>(
      'AllVisitsProfession/$profession',
    );
    List<PatientAppointment> appointments = [];
    final List<dynamic> lists = response.data;

    print(lists[0][0] is int);
    for (int i = 0; i < lists.length; i++) {
      int id = 0;
      DateTime startTime = DateTime.now();
      DateTime endTime = DateTime.now();
      String doctorName = '';
      if (lists[i][0] is int) {
        id = lists[i][0];
      }
      if (lists[i][1] is String) {
        startTime = DateTime.parse(lists[i][1]);
      }
      if (lists[i][2] is String) {
        endTime = DateTime.parse(lists[i][2]);
      }
      if (lists[i][3] is String) {
        doctorName = lists[i][3];
      }

      final parsedAppointment = PatientAppointment(
          id: id, start: startTime, end: endTime, doctorName: doctorName);

      appointments.add(parsedAppointment);
    }

    return appointments;
  }
}
