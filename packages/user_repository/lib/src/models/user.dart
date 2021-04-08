import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User(this.id, this.email, this.role);

  final String id;
  final String email;
  final String role;

  @override
  List<Object> get props => [id, email, role];

  static const empty = User('-', 'empty@gmail.com', 'empty');
}
