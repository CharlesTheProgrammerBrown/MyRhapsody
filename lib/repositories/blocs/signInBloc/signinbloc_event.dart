part of 'signinbloc_bloc.dart';

abstract class SignInEvent  {
  @override
  List<Object> get props => [];
}

class LoginEmailChange extends SignInEvent {
  final String email;
  LoginEmailChange({this.email});

  @override
  List<Object> get props => [email];
}

class LoginPasswordChange extends SignInEvent {
  final String password;

  LoginPasswordChange({this.password});

  @override
  List<Object> get props => [password];
}

class LoginWithCredentialsPressed extends SignInEvent {
  final String email;
  final String password;

  LoginWithCredentialsPressed({this.email, this.password});

  @override
  List<Object> get props => [email, password];
}
