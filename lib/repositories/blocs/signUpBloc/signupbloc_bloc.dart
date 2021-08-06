import 'dart:async';


import 'package:MyRhapsody/repositories/models/UserData/firebaseUserDataRepository.dart';
import 'package:MyRhapsody/repositories/models/UserData/userDataModel.dart';
import 'package:MyRhapsody/services/authService.dart';
import 'package:MyRhapsody/services/helperClass.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'signupbloc_event.dart';
part 'signupbloc_state.dart';

class SignUpBloc extends Bloc<SignUpBlocEvent, SignUpBlocState> {
  final FirebaseUserDataRepository _firebaseUserDataRepository =
      FirebaseUserDataRepository();
  final AuthService _authService = AuthService();

  SignUpBloc() : super(SignUpBlocState.initial());

  @override
  Stream<SignUpBlocState> mapEventToState(
    SignUpBlocEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is RegisterEmailChanged) {
      yield* _mapRegisterEmailChangedToState(event.email);
    } else if (event is RegisterNameChanged) {
      yield* _mapRegisterNameChangedToState(event.name);
    } else if (event is RegisterPasswordChanged) {
      yield* _mapRegisterPasswordChangedToState(event.password);
    } else if (event is RegisterSubmitted) {
      yield* _mapRegisterRegisterSubmittedToState(
          email: event.email, password: event.password, name: event.name,
          language: event.language);
    } 
  }

  Stream<SignUpBlocState> _mapRegisterEmailChangedToState(String email) async* {
    yield state.update(isEmailValid: Validators.isValidEmail(email));
  }

  Stream<SignUpBlocState> _mapRegisterNameChangedToState(String name) async* {
    yield state.update(isNameValid: Validators.isValidName(name));
  }

  Stream<SignUpBlocState> _mapRegisterPasswordChangedToState(
      String password) async* {
    yield state.update(isPasswordValid: Validators.isValidPassword(password));
  }

  Stream<SignUpBlocState> _mapRegisterRegisterSubmittedToState(
      {String email, String password, String name, String language}) async* {
    yield SignUpBlocState.loading();
    try {
      await _authService.registerWithEmailAndPassword(email, password, name);
      await _firebaseUserDataRepository.addUserData(
        UserDataModel(
            email: email,
            name: name,
            language: language,
      )
      );
      yield SignUpBlocState.success();
    
    } catch (error) {
    
      yield SignUpBlocState.failure();
    }
  }

 
}
