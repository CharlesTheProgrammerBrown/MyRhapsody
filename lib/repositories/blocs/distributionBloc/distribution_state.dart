part of 'distribution_bloc.dart';

class DistributionState {
  final bool isEmailValid;

  final bool isNameValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid => isEmailValid  && isNameValid;

//CONSTRUCTOR FOR EVENT VARIABLES
  DistributionState({
    this.isEmailValid,
  
    this.isNameValid,
    this.isSubmitting,
    this.isSuccess,
    this.isFailure,
  });

  //USE FACTORY FOR ADDITIONAL DEPENDENCIES SUCH AS HELPER CLASSES

  factory DistributionState.initial() {
    return DistributionState(
      isEmailValid: true,
    
      isNameValid: true,
      isFailure: false,
      isSubmitting: false,
      isSuccess: false,
    );
  }

  factory DistributionState.loading() {
    return DistributionState(
      isEmailValid: true,
      isNameValid: true,
     
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory DistributionState.failure() {
    return DistributionState(
      isEmailValid: true,
      isNameValid: true,
     
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory DistributionState.success() {
    return DistributionState(
      isEmailValid: true,
      isNameValid: true,
     
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  DistributionState update(
      {bool isEmailValid, bool isPasswordValid, bool isNameValid}) {
    return copyWith(
      isEmailValid: isEmailValid,
     
      isNameValid: isNameValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  DistributionState copyWith({
    bool isEmailValid,
   
    bool isNameValid,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }) {
    return DistributionState(
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isNameValid: isNameValid ?? this.isNameValid,
     
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }
}
