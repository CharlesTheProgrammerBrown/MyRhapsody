

import 'package:MyRhapsody/presentation/launchPages/onBoarding/onBoarding.dart';
import 'package:MyRhapsody/presentation/launchPages/splashPage.dart';
import 'package:MyRhapsody/presentation/signIn/signInPage.dart';
import 'package:MyRhapsody/presentation/signUp/signUpPage.dart';
import 'package:MyRhapsody/services/authService.dart';
import 'package:flutter/material.dart';



class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    //data you're passing
    final AuthService authService = AuthService();
    

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            //made wrapper the root route
            builder: (BuildContext context) => SplashPage());
        break;

      case '/signUpPage':
        return MaterialPageRoute(
            builder: (BuildContext context) => SignUpPage());

      case '/signInPage':
        return MaterialPageRoute(
            //made wrapper the root route
            builder: (BuildContext context) => SignInPage());
        break;
    
     case '/onBoardingPage':
        return MaterialPageRoute(
            //made wrapper the root route
            builder: (BuildContext context) => OnBoardingPage());
        break;

    

      // case '/LandingPage':
      //   return MaterialPageRoute(builder: (_) => LandingPage());
    
     
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
