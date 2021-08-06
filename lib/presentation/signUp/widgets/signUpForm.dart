import 'package:MyRhapsody/presentation/core/customStyles.dart';
import 'package:MyRhapsody/repositories/blocs/signUpBloc/signupbloc_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  String language;

  bool get isPopulated =>
      _emailController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty &&
      _nameController.text.isNotEmpty;

  bool isButtonEnabled(SignUpBlocState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  SignUpBloc _signUpBloc;
  // FirstLaunchUserInfoEntryBloc _infoEntryBloc;

  @override
  void initState() {
    super.initState();
    _signUpBloc = BlocProvider.of<SignUpBloc>(context);
    // _infoEntryBloc = BlocProvider.of<FirstLaunchUserInfoEntryBloc>(context);
    _nameController.addListener(() {
      _signUpBloc.add(
        RegisterNameChanged(name: _nameController.text),
      );
    });

    _emailController.addListener(() {
      _signUpBloc.add(
        RegisterEmailChanged(email: _emailController.text),
      );
    });

    _passwordController.addListener(() {
      _signUpBloc.add(
        RegisterPasswordChanged(password: _passwordController.text),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpBlocState>(
      listener: (context, state) {
        if (state.isFailure) {
          Future.delayed(const Duration(seconds: 1), () {
            Scaffold.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Registration Failed, try again!'),
                        Icon(Icons.error),
                      ],
                    ),
                    backgroundColor: Colors.red),
              );
          });
        } else if (state.isSubmitting) {
          Scaffold.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: <Widget>[
                    const Text('Registering...'),
                    const CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.redAccent),
                    )
                  ],
                ),
              ),
            );
          Future.delayed(const Duration(seconds: 1), () {});
        } else if (state.isSuccess) {
          Scaffold.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: <Widget>[
                      const Text('Successfully Registered! Logging In'),
                      const Icon(
                        Icons.done_all,
                      ),
                    ],
                  ),
                  backgroundColor: Colors.green),
            );
          // BlocProvider.of<AuthenticationBloc>(context).add(
          //   AuthenticationLoggedIn(),
          // );

          Navigator.pushNamed(context, '/');
        }
      },
      child: BlocBuilder<SignUpBloc, SignUpBlocState>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 8.0,
            ),
            child: Form(
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      const Text(
                        'SIGN UP',
                        style: TextStyle(
                          letterSpacing: 2,
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                            height: 50,
                            child: buildNameFormField(context, 'Full Name')),
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
                            child: buildPasswordFormField(context, 'Password')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.white,
                          ),
                          //  height: 50,
                          child: DropdownButtonFormField<String>(
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            dropdownColor: Colors.white,
                            isExpanded: true,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10.0),
                              //fillColor: Colors.white,

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(width: 2.0),
                              ),
                              // focusedBorder: OutlineInputBorder(
                              //   borderSide: BorderSide(width: 2.0),
                              // ),
                              // disabledBorder: OutlineInputBorder(
                              //   borderSide: BorderSide(width: 2.0),
                              // ),
                              // enabledBorder: OutlineInputBorder(
                              //   borderSide: BorderSide(width: 2.0),
                              // ),
                            ),
                            // isExpanded: false,
                            hint: const Align(
                              child: Text(
                                "Languages",
                                style: TextStyle(
                                  letterSpacing: 1,
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            elevation: 2,
                            iconSize: 30.0,
                            focusColor: Colors.white,
                            iconEnabledColor: primaryColor,
                            iconDisabledColor: Colors.white,
                            onChanged: (value) async {
                              setState(() {
                                language = value;
                              });
                            },
                            value: language,
                            items: const [
                              DropdownMenuItem(
                                value: "English",
                                child: Align(
                                  child: Text(
                                    'English',
                                    style: TextStyle(
                                      letterSpacing: 1,
//color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              DropdownMenuItem(
                                value: "Spanish",
                                child: Align(
                                  child: Text(
                                    'Spanish',
                                    style: TextStyle(
                                      letterSpacing: 1,
                                      // color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              DropdownMenuItem(
                                value: "French",
                                child: Align(
                                  child: Text(
                                    'French',
                                    style: TextStyle(
                                      letterSpacing: 1,
                                      //color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      //password confirmation
                      //  buildConfirmPasswordFormField(context, 'Re-Enter Password'),
                      const SizedBox(height: 15),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      FlatButton(
                        color: primaryColor,
                        onPressed: () async {
                          if (isButtonEnabled(state)) {
                            _onFormSubmitted();

                            Navigator.pushNamed(context, '/home');
                          }
                          //ExtendedNavigator.of(context).replace(Routes.intro);
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        child: Container(
                          height: 40,
                          width: 160,
                          alignment: Alignment.center,
                          child: Text(
                            'Get Started',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an account? ',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Sign In',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  TextFormField buildNameFormField(BuildContext context, String _hintText) {
    return TextFormField(
        style: TextStyle(
          color: Colors.black,
        ),
        keyboardType: TextInputType.name,
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
            Icons.person,
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
        controller: _nameController,
        validator: (_) =>
            context.read<SignUpBloc>().state.isNameValid ? null : 'Invalid Name'
        // autofocus: false,
        );
  }

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
        validator: (_) => context.read<SignUpBloc>().state.isEmailValid
            ? null
            : 'Invalid Email'
        // autofocus: false,
        );
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
        validator: (_) => context.read<SignUpBloc>().state.isPasswordValid
            ? null
            : 'Invalid Password: must be greater than 6 char');
  }

  void _onFormSubmitted() {
    _signUpBloc.add(
      RegisterSubmitted(
        email: _emailController.text,
        name: _nameController.text,
        password: _passwordController.text,
      ),
    );
  }

  @override
  void dispose() {
    _emailController?.dispose();
    _passwordController?.dispose();
    _nameController?.dispose();

    super.dispose();
  }
}
