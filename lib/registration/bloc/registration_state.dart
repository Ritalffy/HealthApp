part of 'registration_bloc.dart';

class RegistrationState extends Equatable {
  const RegistrationState._({
    this.status = RegistrationStatus.unknown,
    this.user = User.empty,
  });

  const RegistrationState.unknown() : this._();

  const RegistrationState.registered(User user)
      : this._(status: RegistrationStatus.registered, user: user);

  const RegistrationState.error() : this._(status: RegistrationStatus.error);

  final RegistrationStatus status;
  final User user;

  @override
  List<Object> get props => [status, user];
}
