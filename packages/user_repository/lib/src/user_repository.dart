import 'dart:async';
import 'models/models.dart';

class UserRepository {
  User? _user;

  Future<User?> getAuth() async {
    if (_user != null) return _user;
    return Future.delayed(
      const Duration(milliseconds: 300),
      () => _user = User.empty,
    );
  }

  Future<User?> getUser() async {
    if (_user != null) return _user;
    return Future.delayed(
      const Duration(milliseconds: 300),
      () => _user = User('id', 'email', 'profession', 'role'),
    );
  }
}
