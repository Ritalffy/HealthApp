part of 'registration_bloc.dart';

class RegistrationBlocInitial extends RegistrationBlocState {}

class RegistrationBlocState extends Equatable {
  const RegistrationBlocState({
    this.status = FormzStatus.pure,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.profession,
    this.role = 'patient',
  });

  final FormzStatus status;
  final Email email;
  final Password password;
  final Profession? profession;
  final String role;

  RegistrationBlocState copyWith({
    FormzStatus? status,
    Email? email,
    Password? password,
    Profession? profession,
    String? role,
  }) {
    return RegistrationBlocState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      profession: profession ?? this.profession,
      role: role ?? this.role,
    );
  }

  @override
  List<Object> get props => [status, email, password, role];
}
