import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Color(0xFF2A276C),
          // width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image.asset(
                "assets/logos/ROR.jpg",
                width: 300, //MediaQuery.of(context).size.width / 2,
                height: 300,
              ),
              const SizedBox(height: 15),
              const SpinKitWave(
                color: Colors.white,
                // size: 50.0,
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
