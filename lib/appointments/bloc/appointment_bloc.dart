import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';

part 'appointment_event.dart';
part 'appointment_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  // TODO: (Wiktoria) add new repository for appointments
  AppointmentBloc() : super(AppointmentState());

  @override
  Stream<AppointmentState> mapEventToState(
    AppointmentEvent event,
  ) async* {
    if (event is ProfessionChanged) {
      yield _mapProfessionChangedToState(event, state);
    } else if (event is AppointmentDateChanged) {
      yield _mapAppointmentDateChangedToState(event, state);
    }
    throw UnsupportedError(event.toString());
  }

  AppointmentState _mapProfessionChangedToState(
    ProfessionChanged event,
    AppointmentState state,
  ) {
    return state.copyWith(selectedDoctorProffesion: event.profession);
  }

  AppointmentState _mapAppointmentDateChangedToState(
    AppointmentDateChanged event,
    AppointmentState state,
  ) {
    return state.copyWith(appointmentDate: event.appointmentDate);
  }
}
