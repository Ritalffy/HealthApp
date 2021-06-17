part of 'registration_bloc.dart';

class RegistrationBlocInitial extends RegistrationBlocState {}

enum ProfessionStatus {
  unused,
  loading,
  fetched,
  error,
}

class RegistrationBlocState extends Equatable {
  const RegistrationBlocState({
    this.status = FormzStatus.pure,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.profession = '',
    this.professionStatus = ProfessionStatus.unused,
    this.role = 'patient',
    this.avaiableProfessions = const [],
  });

  final FormzStatus status;
  final Email email;
  final Password password;
  final String profession;
  final String role;
  final ProfessionStatus professionStatus;
  final List<String> avaiableProfessions;

  RegistrationBlocState copyWith({
    FormzStatus? status,
    Email? email,
    Password? password,
    String? profession,
    String? role,
    List<String>? avaiableProfessions,
    ProfessionStatus? professionStatus,
  }) {
    return RegistrationBlocState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      profession: profession ?? this.profession,
      role: role ?? this.role,
      professionStatus: professionStatus ?? this.professionStatus,
      avaiableProfessions: avaiableProfessions ?? this.avaiableProfessions,
    );
  }

  @override
  List<Object> get props => [
        status,
        email,
        password,
        role,
        professionStatus,
        avaiableProfessions,
        profession,
      ];
}
