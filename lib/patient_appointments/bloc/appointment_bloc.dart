import 'dart:async';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:authentication_repository/models/appointment.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';

part 'appointment_event.dart';
part 'appointment_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  AppointmentBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(AppointmentState());

  final AuthenticationRepository _authenticationRepository;
  @override
  Stream<AppointmentState> mapEventToState(
    AppointmentEvent event,
  ) async* {
    if (event is ProfessionChanged) {
      yield _mapProfessionChangedToState(event, state);
    } else if (event is AppointmentDateChanged) {
      yield _mapAppointmentDateChangedToState(event, state);
    } else if (event is FetchAppointments) {
      yield* _mapFetchAppointmentsToState(event, state);
    } else if (event is FetchProfessions) {
      yield* _mapFetchProfessionsToState(event, state);
    }
  }

  Stream<AppointmentState> _mapFetchProfessionsToState(
    AppointmentEvent event,
    AppointmentState state,
  ) async* {
    yield state.copyWith(professionStatus: ProfessionStatus.loading);
    try {
      final List<String> professions =
          await _authenticationRepository.getProfessions();

      yield state.copyWith(
        avaiableProfessions: professions,
        professionStatus: ProfessionStatus.fetched,
      );
    } on DioError catch (err) {
      print(err.response);
      yield state.copyWith(professionStatus: ProfessionStatus.error);
    }
  }

  Stream<AppointmentState> _mapFetchAppointmentsToState(
    AppointmentEvent event,
    AppointmentState state,
  ) async* {
    yield state.copyWith(
        avaiableAppointmentStatus: AvaiableAppointmentStatus.loading);
    try {
      print(state.selectedDoctorProffesion);
      final List<PatientAppointment> appointments =
          await _authenticationRepository
              .getAppointmentForProfession(state.selectedDoctorProffesion);
      print(appointments.length);

      yield state.copyWith(
        avaiableAppointmentStatus: AvaiableAppointmentStatus.fetched,
      );
    } on DioError catch (err) {
      print(err.response);
      yield state.copyWith(professionStatus: ProfessionStatus.error);
    }
  }

  AppointmentState _mapProfessionChangedToState(
    ProfessionChanged event,
    AppointmentState state,
  ) {
    print('invoked  event ${event.profession}');
    return state.copyWith(selectedDoctorProffesion: event.profession);
  }

  AppointmentState _mapAppointmentDateChangedToState(
    AppointmentDateChanged event,
    AppointmentState state,
  ) {
    print('invoked  event ${event.appointmentDate}');
    return state.copyWith(appointmentDate: event.appointmentDate);
  }
}
