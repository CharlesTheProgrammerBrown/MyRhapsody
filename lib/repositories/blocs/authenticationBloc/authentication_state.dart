part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {
  @override
  String toString() => "UserState: UserUndefined";
}

class AuthenticationSuccess extends AuthenticationState {
  final User firebaseUser;

  const AuthenticationSuccess({this.firebaseUser});
  @override
  List<Object> get props => [firebaseUser];

  // @override
  // String toString() =>
  //     "UserState: UserLoggedIn {firebaseUser: ${firebaseUser.displayName} ${firebaseUser.email} }";
}

class AuthenticationFailure extends AuthenticationState {
  @override
  String toString() => "UserState: UserLoggedOut";
}

