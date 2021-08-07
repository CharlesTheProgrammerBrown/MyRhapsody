import 'dart:async';

import 'package:MyRhapsody/repositories/models/UserData/firebaseUserDataRepository.dart';
import 'package:MyRhapsody/services/authService.dart';
import 'package:MyRhapsody/services/helperClass.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'signinbloc_event.dart';
part 'signinbloc_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthService _authService = AuthService();
  final FirebaseUserDataRepository _firebaseUserDataRepository =
      FirebaseUserDataRepository();

  SignInBloc() : super(SignInState.initial());

  @override
  Stream<SignInState> mapEventToState(
    SignInEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is LoginEmailChange) {
      yield* _mapLoginEmailChangeToState(event.email);
    } else if (event is LoginPasswordChange) {
      yield* _mapLoginPasswordChangeToState(event.password);
    } else if (event is LoginWithCredentialsPressed) {
      yield* _mapLoginWithCredentialsPressedToState(
          email: event.email, password: event.password);
    }
  }

  Stream<SignInState> _mapLoginEmailChangeToState(String email) async* {
    yield state.update(isEmailValid: Validators.isValidEmail(email));
  }

  Stream<SignInState> _mapLoginPasswordChangeToState(String password) async* {
    yield state.update(isPasswordValid: Validators.isValidPassword(password));
  }

  Stream<SignInState> _mapLoginWithCredentialsPressedToState(
      {String email, String password}) async* {
    yield SignInState.loading();
    try {
      await _authService.signInWithEmailAndPassword(email, password);
      yield SignInState.success();
    } catch (e) {
      yield SignInState.failed();
    }
  }
}
