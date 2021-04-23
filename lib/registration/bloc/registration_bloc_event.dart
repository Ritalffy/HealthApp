part of 'registration_bloc.dart';

abstract class RegistrationBlocEvent extends Equatable {
  const RegistrationBlocEvent();

  @override
  List<Object> get props => [];
}

class RegisterEmailChanged extends RegistrationBlocEvent {
  const RegisterEmailChanged(this.username);

  final String username;

  @override
  List<Object> get props => [username];
}

class RegisterPasswordChanged extends RegistrationBlocEvent {
  const RegisterPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class RegisterRoleChanged extends RegistrationBlocEvent {
  const RegisterRoleChanged(this.role);

  final String role;

  @override
  List<Object> get props => [role];
}

class RegisterProfessionChanged extends RegistrationBlocEvent {
  const RegisterProfessionChanged(this.profession);

  final String profession;

  @override
  List<Object> get props => [profession];
}

class RegisterSubmitted extends RegistrationBlocEvent {
  const RegisterSubmitted();
}
