import 'dart:async';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:health_app/patient_appointments/patient_appointments_page.dart';

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

  AppointmentState _mapProfessionChangedToState(
    ProfessionChanged event,
    AppointmentState state,
  ) {
    print('reveived event ${event.profession}');
    return state.copyWith(selectedDoctorProffesion: event.profession);
  }

  AppointmentState _mapAppointmentDateChangedToState(
    AppointmentDateChanged event,
    AppointmentState state,
  ) {
    print('reveived event ${event.appointmentDate}');
    return state.copyWith(appointmentDate: event.appointmentDate);
  }
}
