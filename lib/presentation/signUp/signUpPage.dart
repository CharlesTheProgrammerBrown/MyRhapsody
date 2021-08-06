import 'package:MyRhapsody/presentation/core/customStyles.dart';
import 'package:MyRhapsody/repositories/blocs/signUpBloc/signupbloc_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/signUpForm.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData().copyWith(errorColor: Colors.yellow),
      child: Scaffold(
        body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: secondaryColor,
            child: CustomScrollView(reverse: true, slivers: <Widget>[
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Image.asset(
                        'assets/logos/MyRhapsody.png',
                        fit: BoxFit.cover,
                        height: 150,
                      ),
                    ),
                    BlocProvider<SignUpBloc>(
                      create: (context) => SignUpBloc(),
                      child: Expanded(
                        child: SignUpForm(),
                      ),
                    ),
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
