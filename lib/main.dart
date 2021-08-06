import 'package:MyRhapsody/presentation/core/customStyles.dart';
import 'package:MyRhapsody/presentation/launchPages/onBoarding/onBoarding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'presentation/signIn/signInPage.dart';
import 'repositories/blocs/signInBloc/signin_bloc.dart';
import 'repositories/models/UserData/firebaseUserDataRepository.dart';
import 'services/authService.dart';
import 'services/generatedRoutes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
//  Bloc.observer = SimpleBlocDelegate();

  await Firebase.initializeApp();
  final AuthService _authService = AuthService();

  final _userDataRepository = FirebaseUserDataRepository();

  runApp(
    Phoenix(
      child: MultiBlocProvider(
        providers: [
          // BlocProvider<AuthenticationBloc>(
          //   create: (context) => AuthenticationBloc(
          //     authService: _authService,
          //   )..add(
          //       AuthenticationStarted(),
          //     ),
          // ),

          BlocProvider<SignInBloc>(
            create: (_) => SignInBloc(),
            // child: FirstView(),
          ),

          // BlocProvider<UserProfileBloc>(
          //   create: (context) =>
          //       UserProfileBloc(userDataRepository: _userDataRepository)
          //         ..add(
          //           InitiateUserProfileCall(),
          //         ),
          // ),
          //BottomNavigationBarIni
        ],
        child: MyApp(
          authService: _authService,
          // notificationRepository: _notificationRepository
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final AuthService _authService;

  const MyApp({
    Key key,
    @required AuthService authService,
  })  : assert(authService != null),
        _authService = authService,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: secondaryColor,
        ),
        child: MaterialApp(
            title: 'MyRhapsody',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              // fontFamily: 'HelveticaNeue',
              // primarySwatch: Colors.blue[900], //const Color(0xFFf857a6),
              errorColor: Colors.red,
              canvasColor: secondaryColor,
              primaryColor: primaryColor,
              //const Color(0XFFEEABC4),
              indicatorColor: Colors.black,
            ),
            onGenerateRoute: RouteGenerator.generateRoute,
            home: OnBoardingPage()));

    //SignInPage());
  }
}
