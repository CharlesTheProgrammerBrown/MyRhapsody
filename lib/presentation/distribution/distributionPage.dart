import 'package:MyRhapsody/presentation/core/customStyles.dart';
import 'package:MyRhapsody/presentation/distribution/widget/distributionForm.dart';
import 'package:MyRhapsody/repositories/blocs/distributionBloc/distribution_bloc.dart';
import 'package:MyRhapsody/repositories/blocs/signUpBloc/signupbloc_bloc.dart';
import 'package:MyRhapsody/theme/styles.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class DistributionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData().copyWith(errorColor: Colors.yellow),
      child: Scaffold(
        body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Styles.colorSecondary,
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
                    BlocProvider<DistributionBloc>(
                      create: (context) => DistributionBloc(),
                      child: Expanded(
                        child: DistributionForm(),
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
