part of 'signupbloc_bloc.dart';

class SignUpBlocState {
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isNameValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid => isEmailValid && isPasswordValid && isNameValid;

//CONSTRUCTOR FOR EVENT VARIABLES
  SignUpBlocState({
    this.isEmailValid,
    this.isPasswordValid,
    this.isNameValid,
    this.isSubmitting,
    this.isSuccess,
    this.isFailure,
  });

  //USE FACTORY FOR ADDITIONAL DEPENDENCIES SUCH AS HELPER CLASSES

  factory SignUpBlocState.initial() {
    return SignUpBlocState(
      isEmailValid: true,
      isPasswordValid: true,
      isNameValid: true,
      isFailure: false,
      isSubmitting: false,
      isSuccess: false,
    );
  }

  factory SignUpBlocState.loading() {
    return SignUpBlocState(
      isEmailValid: true,
      isNameValid: true,
      isPasswordValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory SignUpBlocState.failure() {
    return SignUpBlocState(
      isEmailValid: true,
      isNameValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory SignUpBlocState.success() {
    return SignUpBlocState(
      isEmailValid: true,
      isNameValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  SignUpBlocState update(
      {bool isEmailValid, bool isPasswordValid, bool isNameValid}) {
    return copyWith(
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      isNameValid: isNameValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  SignUpBlocState copyWith({
    bool isEmailValid,
    bool isPasswordValid,
    bool isNameValid,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }) {
    return SignUpBlocState(
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isNameValid: isNameValid ?? this.isNameValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }
}
