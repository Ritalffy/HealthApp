part of 'appointment_bloc.dart';

abstract class AppointmentEvent extends Equatable {
  const AppointmentEvent();

  @override
  List<Object> get props => [];
}

class ProfessionChanged extends AppointmentEvent {
  const ProfessionChanged(this.profession);

  final String profession;

  @override
  List<Object> get props => [profession];
}

class FetchProfessions extends AppointmentEvent {
  const FetchProfessions();
}

class AppointmentDateChanged extends AppointmentEvent {
  const AppointmentDateChanged(this.appointmentDate);

  final String appointmentDate;

  @override
  List<Object> get props => [appointmentDate];
}
