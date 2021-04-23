import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User(this.id, this.email, this.profession, this.role);

  final String id;
  final String email;
  final String role;
  final String? profession;

  @override
  List<Object> get props => [id];

  static const empty = User('id', 'empty@emial.com', null, 'patient');
}
