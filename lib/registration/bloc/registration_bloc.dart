import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:health_app/registration/models/models.dart';
import 'package:health_app/registration/models/profession.dart';

part 'registration_bloc_event.dart';
part 'registration_bloc_state.dart';

class RegistrationBloc
    extends Bloc<RegistrationBlocEvent, RegistrationBlocState> {
  RegistrationBloc() : super(RegistrationBlocInitial());

  @override
  Stream<RegistrationBlocState> mapEventToState(
    RegistrationBlocEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
