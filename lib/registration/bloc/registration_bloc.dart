import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:health_app/registration/models/models.dart';
import 'package:health_app/registration/models/profession.dart';
import 'package:register_repository/register_repository.dart';

part 'registration_bloc_event.dart';
part 'registration_bloc_state.dart';

class RegistrationBloc
    extends Bloc<RegistrationBlocEvent, RegistrationBlocState> {
  RegistrationBloc({
    required RegisterRepository registerRepository,
  })   : _registerRepository = registerRepository,
        super(const RegistrationBlocState());

  final RegisterRepository _registerRepository;

  @override
  Stream<RegistrationBlocState> mapEventToState(
    RegistrationBlocEvent event,
  ) async* {
    if (event is RegisterEmailChanged) {
      yield _mapUsernameChangedToState(event, state);
    } else if (event is RegisterPasswordChanged) {
      yield _mapPasswordChangedToState(event, state);
    } else if (event is RegisterProfessionChanged) {
      yield _mapProfessionChangedToState(event, state);
    } else if (event is RegisterRoleChanged) {
      yield* _mapRoleChangedToState(event, state);
    } else if (event is RegisterSubmitted) {
      yield* _mapRegisterSubmittedToState(event, state);
    }
  }

  RegistrationBlocState _mapUsernameChangedToState(
    RegisterEmailChanged event,
    RegistrationBlocState state,
  ) {
    final email = Email.dirty(event.username);
    return state.copyWith(
      email: email,
      status: Formz.validate([state.password, email]),
    );
  }

  RegistrationBlocState _mapPasswordChangedToState(
    RegisterPasswordChanged event,
    RegistrationBlocState state,
  ) {
    final password = Password.dirty(event.password);
    return state.copyWith(
      password: password,
      status: Formz.validate([password, state.email]),
    );
  }

  RegistrationBlocState _mapProfessionChangedToState(
    RegisterProfessionChanged event,
    RegistrationBlocState state,
  ) {
    final profession = Profession.dirty(event.profession);
    return state.copyWith(profession: profession);
  }

  Stream<RegistrationBlocState> _mapRoleChangedToState(
    RegisterRoleChanged event,
    RegistrationBlocState state,
  ) async* {
    yield state.copyWith(role: event.role);
  }

  Stream<RegistrationBlocState> _mapRegisterSubmittedToState(
    RegisterSubmitted event,
    RegistrationBlocState state,
  ) async* {
    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      try {
        await _registerRepository.register(
          email: state.email.value,
          password: state.password.value,
          role: state.role,
          profession: state.profession?.value,
        );
        yield state.copyWith(status: FormzStatus.submissionSuccess);
      } on Exception catch (_) {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    }
  }
}
