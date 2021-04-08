import 'dart:async';

enum RegisterStatus { unknown, registered, error }

class RegisterRepository {
  final _controller = StreamController<RegisterStatus>();

  Stream<RegisterStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield RegisterStatus.unknown;
    yield* _controller.stream;
  }

  Future<void> register({
    required String email,
    required String password,
    required String role,
  }) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
      () => _controller.add(RegisterStatus.registered),
    );
  }

  void dispose() => _controller.close();
}
