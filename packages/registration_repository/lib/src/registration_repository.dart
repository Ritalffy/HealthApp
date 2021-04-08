import 'dart:async';

enum RegistrationStatus { unknown, registered, error }

class RegistrationRepository {
  final _controller = StreamController<RegistrationStatus>();

  Stream<RegistrationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield RegistrationStatus.unknown;
    yield* _controller.stream;
  }

  Future<void> register({
    required String email,
    required String password,
    required String role,
  }) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
      () => _controller.add(RegistrationStatus.registered),
    );
  }

  void dispose() => _controller.close();
}
