part of 'signupbloc_bloc.dart';

abstract class SignUpBlocEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterEmailChanged extends SignUpBlocEvent {
  final String email;

  RegisterEmailChanged({this.email});

  @override
  List<Object> get props => [email];
}

class RegisterNameChanged extends SignUpBlocEvent {
  final String name;

  RegisterNameChanged({this.name});

  @override
  List<Object> get props => [name];
}

class RegisterPasswordChanged extends SignUpBlocEvent {
  final String password;

  RegisterPasswordChanged({this.password});

  @override
  List<Object> get props => [password];
}

class RegisterSubmitted extends SignUpBlocEvent {
  final String email;
  final String password;
  final String name;
  final String language;

  RegisterSubmitted({this.email, this.password, this.name, this.language});

  @override
  List<Object> get props => [email, password, name, language];
}
