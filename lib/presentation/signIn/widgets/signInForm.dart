//import 'dart:js';

import 'package:MyRhapsody/presentation/core/customStyles.dart';
import 'package:MyRhapsody/presentation/signUp/signUpPage.dart';
import 'package:MyRhapsody/repositories/blocs/signInBloc/signin_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';

import 'package:flutter_phoenix/flutter_phoenix.dart';

class SignInForm extends StatefulWidget {
  // const SignInForm({Key signInFormKey, AuthService authService})
  //     : _authService = authService,
  //       super(key: signInFormKey);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isButtonEnabled(SignInState state) {
    final result = state.isFormValid && isPopulated && !state.isSubmitting;

    return result;
  }

  SignInBloc _signInBloc;

  @override
  void initState() {
    super.initState();
    _signInBloc = BlocProvider.of<SignInBloc>(context);
    _emailController.addListener(
      () {
        _signInBloc.add(
          LoginEmailChange(email: _emailController.text),
        );
      },
    );

    _passwordController.addListener(() {
      _signInBloc.add(
        LoginPasswordChange(password: _passwordController.text),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    //want to build using blocbuilder and listen for state changes using bloclistener--combine
    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state.isFailure) {
          Scaffold.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                backgroundColor: secondaryColor,
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Login Failure'),
                    Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            );
        } else if (state.isSubmitting) {
          Scaffold.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                backgroundColor: secondaryColor,
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Logging In...'),
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
                    )
                  ],
                ),
              ),
            );
        } else if (state.isSuccess) {
          Scaffold.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                backgroundColor: secondaryColor,
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Login Success...'),
                    Icon(Icons.done_all, color: Colors.green),
                  ],
                ),
              ),
            );
          // Future.delayed(const Duration(seconds: 1), () {
          //   BlocProvider.of<AuthenticationBloc>(context).add(
          //     AuthenticationLoggedIn(),
          //   );
          //   Phoenix.rebirth(context);
          //   // Navigator.pushNamed(context, '/');
          // });
        }
      },
      child: BlocBuilder<SignInBloc, SignInState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: secondaryColor,
                ),
                height: 450,
                child: Column(children: [
                  Form(
                    autovalidateMode: AutovalidateMode.always,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'SIGN IN',
                          style: TextStyle(
                            letterSpacing: 2,
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                              height: 50,
                              child: buildEmailFormField(context, 'Email')),
                        ),
                        //Password field
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                              height: 50,
                              child:
                                  buildPasswordFormField(context, 'Password')),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(
                            top: 4.0,
                            left: 20,
                            bottom: 5.0,
                            right: 20,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [
                              Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FlatButton(
                          color: primaryColor,
                          onPressed: () {
                            if (isButtonEnabled(state)) {
                              _signInBloc.add(
                                LoginWithCredentialsPressed(
                                    email: _emailController.text,
                                    password: _passwordController.text),
                              );
                            }
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          child: Container(
                            height: 40,
                            width: 200,
                            alignment: Alignment.center,
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't have an account? ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w400),
                              ),
                              GestureDetector(
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return SignUpPage();
                                      },
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          );
        },
      ),
    );
  }

  // Column(
  //                 children: <Widget>[
  //                   FlatButton(
  //                     color: Colors.white,
  //                     onPressed: () {
  //                       if (isButtonEnabled(state)) {
  //                         _signInBloc.add(
  //                           LoginWithCredentialsPressed(
  //                               email: _emailController.text,
  //                               password: _passwordController.text),
  //                         );
  //                       }
  //                     },
  //                     shape: RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.circular(18.0),
  //                     ),
  //                     child: Container(
  //                       height: 40,
  //                       width: 160,
  //                       alignment: Alignment.center,
  //                       child: const Text(
  //                         'Login',
  //                         style: TextStyle(
  //                           color: primaryColor,
  //                           fontWeight: FontWeight.bold,
  //                           fontSize: 17,
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                   // const SizedBox(
  //                   //   height: 10,
  //                   // ),
  //                   const HeaderDividerWidget(),
  //                   FlatButton(
  //                     color: Colors.white,
  //                     shape: const OutlineInputBorder(
  //                         borderSide: BorderSide.none),
  //                     onPressed: () {
  //                       // Navigator.pop(context);
  //                       Navigator.of(context)
  //                           .pushReplacementNamed('/FirstView');
  //                     },
  //                     child: const Text(
  //                       "Cancel",
  //                       style: TextStyle(
  //                         fontSize: 15,
  //                         color: Colors.black54, // Color(0xFFff5858),
  //                       ),
  //                     ),
  //                   ),

  //                   // Navigator.of(context)
  //                   //  .pushReplacementNamed('/signInPage');
  //                   Padding(
  //                     padding: const EdgeInsets.symmetric(
  //                       vertical: 15.0,
  //                       horizontal: 20,
  //                     ),
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         const Text(
  //                           "Don't have an account? ",
  //                           style: TextStyle(
  //                               color: Colors.white,
  //                               fontSize: 18.0,
  //                               fontWeight: FontWeight.w400),
  //                         ),
  //                         GestureDetector(
  //                           onTap: () {
  //                             FocusScope.of(context).unfocus();
  //                             Navigator.push(
  //                               context,
  //                               MaterialPageRoute(
  //                                 builder: (context) {
  //                                   return SignUpPage();
  //                                 },
  //                               ),
  //                             );
  //                           },
  //                           child: const Text(
  //                             'Sign Up',
  //                             style: TextStyle(
  //                                 color: Colors.white,
  //                                 fontSize: 20.0,
  //                                 fontWeight: FontWeight.bold),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),

  TextFormField buildEmailFormField(BuildContext context, String _hintText) {
    return TextFormField(
        style: TextStyle(
          color: Colors.black,
        ),
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          errorStyle: const TextStyle(fontSize: 15),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          fillColor: Colors.white,
//focusColor: Colors.white,
          filled: true,
          prefixIcon: const Icon(
            Icons.email,
          ),
          labelText: _hintText,
          labelStyle: const TextStyle(
            letterSpacing: 1,
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontSize: 15,
          ),
        ),
        autocorrect: false,
        //autofocus: false,
        controller: _emailController,
        // need to show UI where validation message is
        //get onchanged from bloc state and not builder(builder 1 char behing until rebuild)
        validator: (_) {
          return !context.read<SignInBloc>().state.isEmailValid
              ? 'Invalid Email'
              : null;
        });
  }

  TextFormField buildPasswordFormField(BuildContext context, String _hintText) {
    return TextFormField(
      style: TextStyle(
        color: Colors.black,
      ),
      decoration: InputDecoration(
        errorStyle: const TextStyle(fontSize: 15),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        fillColor: Colors.white,
//focusColor: Colors.white,
        filled: true,

        prefixIcon: const Icon(
          Icons.lock,
        ),
        labelText: _hintText,
        labelStyle: const TextStyle(
          letterSpacing: 1,
          fontWeight: FontWeight.normal,
          fontSize: 15,
        ),
      ),
      autocorrect: false,
      // autofocus: false,
      obscureText: true,
      controller: _passwordController,
      validator: (_) {
        return !context.read<SignInBloc>().state.isPasswordValid
            ? 'Invalid Password'
            : null;
      },
    );
  }
}

class HeaderDividerWidget extends StatelessWidget {
  const HeaderDividerWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Column(
        children: const [
          Divider(
            thickness: 1,
            color: Colors.white,
            height: 30,
          ),
        ],
      ),
    );
  }
}
