import 'dart:async';

import 'package:MyRhapsody/services/authService.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthService _authService;

  AuthenticationBloc({AuthService authService})
      : _authService = authService,
        super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is AuthenticationStarted) {
      yield* _mapAuthenticationStartedToState();
    } else if (event is AuthenticationLoggedIn) {
      yield* _mapAuthenticationLoggedInToState();
    } else if (event is AuthenticationLoggedOut) {
      yield* _mapAuthenticationLoggedOutToState(event);
    }
  }

  Stream<AuthenticationState> _mapAuthenticationStartedToState() async* {
    final isSignedIn = _authService.isSignedIn();
    if (isSignedIn) {
      yield const AuthenticationSuccess();
    } else {
      yield AuthenticationFailure();
    }
  }

  Stream<AuthenticationState> _mapAuthenticationLoggedInToState() async* {
    try {
      final isSignedIn = _authService.isSignedIn();
      if (isSignedIn) {
        //final _firebaseUser =  _authService.getCurrentUser();
        yield const AuthenticationSuccess();
      } else {
        yield AuthenticationFailure();
      }
    } catch (e) {
  
      yield AuthenticationFailure();
    }
  }

  Stream<AuthenticationState> _mapAuthenticationLoggedOutToState(
      AuthenticationLoggedOut event) async* {
    await _authService.signOut();
    //Phoenix.rebirth(event.context);
    yield AuthenticationFailure();
  }
}
