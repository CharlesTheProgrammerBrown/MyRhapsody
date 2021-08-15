import 'package:MyRhapsody/presentation/core/customStyles.dart';
import 'package:MyRhapsody/presentation/home/homePage.dart';
import 'package:MyRhapsody/presentation/launchPages/onBoarding/onBoarding.dart';
import 'package:MyRhapsody/presentation/launchPages/splashPage.dart';
import 'package:MyRhapsody/repositories/blocs/authenticationBloc/authentication_bloc.dart';
import 'package:MyRhapsody/repositories/blocs/signInBloc/signinbloc_bloc.dart';
import 'package:MyRhapsody/repositories/blocs/signUpBloc/signupbloc_bloc.dart';
import 'package:MyRhapsody/repositories/models/LanguageModel/bloc/language_bloc.dart';
import 'package:MyRhapsody/theme/styles.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'presentation/signIn/signInPage.dart';

import 'repositories/blocs/bloc_observer.dart';
import 'repositories/models/UserData/firebaseUserDataRepository.dart';
import 'services/authService.dart';
import 'services/generatedRoutes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
//  Bloc.observer = SimpleBlocDelegate();
  Bloc.observer = SimpleBlocDelegate();
  await Firebase.initializeApp();
  final AuthService _authService = AuthService();

  final _userDataRepository = FirebaseUserDataRepository();

  runApp(
    Phoenix(
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (context) => AuthenticationBloc(
              authService: _authService,
            )..add(
                AuthenticationStarted(),
              ),
          ),

          BlocProvider<SignInBloc>(
            create: (_) => SignInBloc(),
            // child: FirstView(),
          ),
          BlocProvider<LanguageBloc>(create: (_) => LanguageBloc()..add(LoadLanguages())
              // child: FirstView(),
              ),

          BlocProvider<SignUpBloc>(
            create: (_) => SignUpBloc(),
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
        statusBarColor: Styles.colorSecondary,
      ),
      child: MaterialApp(
        title: 'MyRhapsody',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // fontFamily: 'HelveticaNeue',
          // primarySwatch: Colors.blue[900], //const Color(0xFFf857a6),
          errorColor: Colors.red,
          canvasColor: Styles.colorSecondary,
          primaryColor: Styles.colorPrimary,
          //const Color(0XFFEEABC4),
          indicatorColor: Colors.black,
        ),
        onGenerateRoute: RouteGenerator.generateRoute,
        home: AppGeneral(authService: _authService),
        // OnBoardingPage()));
      ),
    );
    //SignInPage());
  }
}

class AppGeneral extends StatelessWidget {
  final AuthService _authService;

  const AppGeneral({
    Key key,
    @required AuthService authService,
  })  : _authService = authService,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is AuthenticationInitial) {
          Future.delayed(const Duration(seconds: 3), () {
            return SplashPage();
          });
        } else if (state is AuthenticationFailure) {
          return OnBoardingPage(); //SignInPage();
        } else if (state is AuthenticationSuccess) {
          return HomePage(); //SignInPage();
        }
        return Container();
      },
    );
  }
}
