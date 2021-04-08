import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:registration_repository/registration_repository.dart';
import 'package:user_repository/user_repository.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc({
    required RegistrationRepository registrationRepository,
    required UserRepository userRepository,
  })   : _registrationRepository = registrationRepository,
        _userRepository = userRepository,
        super(const RegistrationState.unknown()) {
    _registrationStatusSubscription = _registrationRepository.status.listen(
      (status) => add(RegistrationStatusChanged(status)),
    );
  }

  final RegistrationRepository _registrationRepository;
  final UserRepository _userRepository;
  late StreamSubscription<RegistrationStatus> _registrationStatusSubscription;

  @override
  Stream<RegistrationState> mapEventToState(
    RegistrationEvent event,
  ) async* {
    if (event is RegistrationStatusChanged) {
      yield await _mapRegistrationStatusChangedToState(event);
    }
  }

  @override
  Future<void> close() {
    _registrationStatusSubscription.cancel();
    _registrationRepository.dispose();
    return super.close();
  }

  Future<RegistrationState> _mapRegistrationStatusChangedToState(
    RegistrationStatusChanged event,
  ) async {
    switch (event.status) {
      case RegistrationStatus.unknown:
        return const RegistrationState.unknown();
      case RegistrationStatus.registered:
        final user = await _tryGetUser();
        return user != null
            ? RegistrationState.registered(user)
            : const RegistrationState.error();
      default:
        return const RegistrationState.unknown();
    }
  }

  Future<User?> _tryGetUser() async {
    try {
      final user = await _userRepository.getUser();
      return user;
    } on Exception {
      return null;
    }
  }
}
