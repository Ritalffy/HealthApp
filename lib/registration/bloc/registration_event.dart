part of 'registration_bloc.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object> get props => [];
}

class RegistrationStatusChanged extends RegistrationEvent {
  const RegistrationStatusChanged(this.status);

  final RegistrationStatus status;

  @override
  List<Object> get props => [status];
}
