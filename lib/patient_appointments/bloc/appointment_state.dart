part of 'appointment_bloc.dart';

class AppointmentInitial extends AppointmentState {}

enum ProfessionStatus {
  unused,
  loading,
  fetched,
  error,
}
enum AvaiableAppointmentStatus {
  unused,
  loading,
  fetched,
  error,
}

class AppointmentState extends Equatable {
  final int appointmentId;
  final String selectedDoctorProffesion;
  final List<String> avaiableProfessions;
  final List<PatientAppointment> avaiableAppointments;
  final AvaiableAppointmentStatus avaiableAppointmentStatus;
  final ProfessionStatus professionStatus;

  AppointmentState({
    this.appointmentId = 0,
    this.selectedDoctorProffesion = '',
    this.avaiableProfessions = const [],
    this.avaiableAppointments = const [],
    this.avaiableAppointmentStatus = AvaiableAppointmentStatus.unused,
    this.professionStatus = ProfessionStatus.unused,
  });
  AppointmentState copyWith({
    int? appointmentId,
    String? selectedDoctorProffesion,
    List<String>? avaiableProfessions,
    List<PatientAppointment>? avaiableAppointments,
    AvaiableAppointmentStatus? avaiableAppointmentStatus,
    ProfessionStatus? professionStatus,
  }) {
    return AppointmentState(
        appointmentId: appointmentId ?? this.appointmentId,
        selectedDoctorProffesion:
            selectedDoctorProffesion ?? this.selectedDoctorProffesion,
        avaiableProfessions: avaiableProfessions ?? this.avaiableProfessions,
        avaiableAppointments: avaiableAppointments ?? this.avaiableAppointments,
        avaiableAppointmentStatus:
            avaiableAppointmentStatus ?? this.avaiableAppointmentStatus,
        professionStatus: professionStatus ?? this.professionStatus);
  }

  @override
  List<Object?> get props => [
        appointmentId,
        selectedDoctorProffesion,
        avaiableProfessions,
        avaiableAppointments,
        avaiableAppointmentStatus,
        professionStatus,
      ];
}
