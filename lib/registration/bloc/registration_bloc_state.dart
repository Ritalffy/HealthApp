part of 'registration_bloc.dart';

class RegistrationBlocInitial extends RegistrationBlocState {}

class RegistrationBlocState extends Equatable {
  const RegistrationBlocState({
    this.status = FormzStatus.pure,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.profession,
  });

  final FormzStatus status;
  final Email email;
  final Password password;
  final Profession? profession;

  RegistrationBlocState copyWith({
    FormzStatus? status,
    Email? email,
    Password? password,
    Profession? profession,
  }) {
    return RegistrationBlocState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      profession: profession ?? this.profession,
    );
  }

  @override
  List<Object> get props => [status, email, password];
}
