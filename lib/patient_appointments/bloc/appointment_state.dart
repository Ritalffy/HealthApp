part of 'appointment_bloc.dart';

class AppointmentInitial extends AppointmentState {}

class AppointmentState extends Equatable {
  final String appointmentDate;
  final String selectedDoctorProffesion;

  AppointmentState({
    this.appointmentDate = '',
    this.selectedDoctorProffesion = '',
  });
  AppointmentState copyWith({
    String? appointmentDate,
    String? selectedDoctorProffesion,
  }) {
    return AppointmentState(
      appointmentDate: appointmentDate ?? this.appointmentDate,
      selectedDoctorProffesion:
          selectedDoctorProffesion ?? this.selectedDoctorProffesion,
    );
  }

  @override
  List<Object?> get props => [appointmentDate, selectedDoctorProffesion];
}
