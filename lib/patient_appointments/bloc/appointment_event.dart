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

class FetchAppointments extends AppointmentEvent {
  const FetchAppointments();
}

class AppointmentDateChanged extends AppointmentEvent {
  const AppointmentDateChanged(this.appointment);

  final PatientAppointment appointment;

  @override
  List<Object> get props => [appointment];
}
