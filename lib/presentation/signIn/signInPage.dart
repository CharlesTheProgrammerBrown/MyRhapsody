import 'package:MyRhapsody/presentation/core/customStyles.dart';
import 'package:MyRhapsody/presentation/signIn/widgets/signInForm.dart';
import 'package:MyRhapsody/repositories/blocs/signInBloc/signin_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatelessWidget {
  // final AuthService _authService;

  // const SignInPage({Key key, AuthService authService})
  //     : _authService = authService,
  //       super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Theme(
        data: ThemeData().copyWith(errorColor: Colors.red, ),
        child: Scaffold(
          body: SafeArea(
            child: Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: CustomScrollView(reverse: true, slivers: <Widget>[
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Image.asset(
                          'assets/logos/MyRhapsody.png',
                          fit: BoxFit.cover,
                          height: 150,
                        ),
                      ),
                      /*SizedBox(height: 5.0)-*/
                      Expanded(
                        child: BlocProvider<SignInBloc>(
                          create: (_) => SignInBloc(),
                          child: SignInForm(),
                        ),
                      ),
                    ],
                  ),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
