import 'package:MyRhapsody/presentation/core/customStyles.dart';
import 'package:MyRhapsody/repositories/blocs/authenticationBloc/authentication_bloc.dart';
import 'package:MyRhapsody/repositories/blocs/distributionBloc/distribution_bloc.dart';
import 'package:MyRhapsody/repositories/blocs/signUpBloc/signupbloc_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DistributionForm extends StatefulWidget {
  @override
  _DistributionFormState createState() => _DistributionFormState();
}

class _DistributionFormState extends State<DistributionForm> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _nameController = TextEditingController();
  String language = "Language";

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _nameController.text.isNotEmpty;

  bool isButtonEnabled(DistributionState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  DistributionBloc distributionBloc;

  // FirstLaunchUserInfoEntryBloc _infoEntryBloc;

  @override
  void initState() {
    super.initState();
    distributionBloc = BlocProvider.of<DistributionBloc>(context);
    // _infoEntryBloc = BlocProvider.of<FirstLaunchUserInfoEntryBloc>(context);
    _nameController.addListener(() {
      distributionBloc.add(
        DistributionNameChanged(name: _nameController.text),
      );
    });

    _emailController.addListener(() {
      distributionBloc.add(
        DistributionEmailChanged(email: _emailController.text),
      );
    });
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
        validator: (_) => context.read<DistributionBloc>().state.isNameValid
            ? null
            : 'Invalid Name'
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

          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),

          errorBorder: OutlineInputBorder(
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
        validator: (_) => context.read<DistributionBloc>().state.isEmailValid
            ? null
            : 'Invalid Email'
        // autofocus: false,
        );
  }

  void _onFormSubmitted() {
    distributionBloc.add(
      DistributionSubmitted(
        email: _emailController.text,
        name: _nameController.text,
        language: language,
      ),
    );
  }

  @override
  void dispose() {
    _emailController?.dispose();

    _nameController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DistributionBloc, DistributionState>(
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
          Flushbar(
            // message: "Creating Campaign!",
            titleText: Text(
              "Hello",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontFamily: "HelveticaNeue"),
            ),
            messageText: Text(
              "Organizing Distribution, Please wait!",
              style: TextStyle(
                  fontSize: 17.0,
                  color: Colors.white,
                  fontFamily: "HelveticaNeue"),
            ),
            flushbarPosition: FlushbarPosition.TOP,
            backgroundColor: primaryColor,
            progressIndicatorBackgroundColor: Colors.white,
            icon: Icon(
              Icons.hourglass_top_outlined,
              color: Colors.white,
            ),
            progressIndicatorValueColor:
                AlwaysStoppedAnimation<Color>(secondaryColor),
            showProgressIndicator: true,
            duration: Duration(seconds: 3),
          ).show(context);
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
          BlocProvider.of<AuthenticationBloc>(context).add(
            AuthenticationLoggedIn(),
          );

          Navigator.pushNamed(context, '/');
        }
      },
      child: BlocBuilder<DistributionBloc, DistributionState>(
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
                        'Rhapsody Distribution',
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
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.white,
                          ),
                          //  height: 50,
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('languages')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData)
                                return DropdownButtonFormField<String>(
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                    dropdownColor: Colors.white,
                                    isExpanded: true,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.only(right: 10.0),
                                      //fillColor: Colors.white,

                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide:
                                            const BorderSide(width: 2.0),
                                      ),
                                    ),
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
                                    //focusColor: Colors.white,
                                    iconEnabledColor: primaryColor,
                                    onChanged: null,
                                    items: const [
                                      DropdownMenuItem(
                                        value: null,
                                        child: Align(
                                          child: Text(
                                            'Loading',
                                            style: TextStyle(
                                              letterSpacing: 1,
                                              color: Colors.black,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]);

                              return DropdownButtonFormField<String>(
                                items: snapshot.data.docs.map(
                                  (fromEachDoc) {
                                    return DropdownMenuItem<String>(
                                      value: fromEachDoc["language"].toString(),
                                      child: Text(
                                        fromEachDoc["language"].toString(),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    );
                                  },
                                ).toList(),
                                onChanged: (selectedLanguage) async {
                                  setState(
                                    () {
                                      language = selectedLanguage;
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),

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

                            // Navigator.pushNamed(context, '/homePage');
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
                            'Distribute',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
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
}
