import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'distribution_event.dart';
part 'distribution_state.dart';



class DistributionBloc extends Bloc<DistributionBlocEvent, DistributionState> {
  final FirebaseDistributionRepository _firebaseDistributionRepository =
      FirebaseDistributionRepository();
  final AuthService _authService = AuthService();

  DistributionBloc() : super(DistributionBloc.initial());

  @override
  Stream<DistributionState> mapEventToState(
    DistributionBlocEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is DistributionEmailChanged) {
      yield* _mapDistributionEmailChangedToState(event.email);
    } else if (event is DistributionNameChanged) {
      yield* _mapDistributionNameChangedToState(event.name);
    } else if (event is DistributionPasswordChanged) {
      yield* _mapDistributionPasswordChangedToState(event.password);
    } else if (event is DistributionSubmitted) {
      yield* _mapDistributionDistributionSubmittedToState(
          email: event.email,
          password: event.password,
          name: event.name,
          language: event.language);
    }
  }

  Stream<DistributionState> _mapDistributionEmailChangedToState(String email) async* {
    yield state.update(isEmailValid: Validators.isValidEmail(email));
  }

  Stream<DistributionState> _mapDistributionNameChangedToState(String name) async* {
    yield state.update(isNameValid: Validators.isValidName(name));
  }

  Stream<DistributionState> _mapDistributionPasswordChangedToState(
      String password) async* {
    yield state.update(isPasswordValid: Validators.isValidPassword(password));
  }

  Stream<DistributionState> _mapDistributionDistributionSubmittedToState(
      {String email, String password, String name, String language}) async* {
    yield DistributionBloc.loading();
    try {
      print("attempt to distribute");
      await _authService.registerWithEmailAndPassword(email, password, name);
      await _firebaseDistributionRepository.addDistributionData(DistributionModel(
        email: email,
        name: name,
        language: language,
      ));
      yield DistributionState.success();
    } catch (error) {
      print(error);
      yield DistributionState.failure();
    }
  }
}
