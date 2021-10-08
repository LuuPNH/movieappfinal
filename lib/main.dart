import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieappfinal/login_screen/authentication_bloc/authentication_bloc.dart';
import 'package:movieappfinal/login_screen/authentication_bloc/authentication_event.dart';
import 'package:movieappfinal/login_screen/authentication_bloc/authentication_state.dart';
import 'package:movieappfinal/login_screen/home_after_login.dart';
import 'package:movieappfinal/login_screen/screens/login/login_screen.dart';
import 'package:movieappfinal/login_screen/simple_bloc_obsever.dart';
import 'package:movieappfinal/repository/user_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  final UserRepository userRepository = UserRepository();
  hihi();
  runApp(
      BlocProvider(
        create: (context) => AuthenticationBloc(userRepository)..add(AuthenticatonStarted()),
        child: MyApp(userRepository: userRepository),
      )
  );
}
 void hihi() {
  print("hello");
}
class MyApp extends StatefulWidget {
  final UserRepository _userRepository;

  MyApp({required UserRepository userRepository}) : _userRepository = userRepository;

  @override
  _MyAppState createState() => _MyAppState(userRepository: _userRepository);
}

class _MyAppState extends State<MyApp> {
  final UserRepository _userRepository;
  @override
  void initState() {

    super.initState();
  }

  _MyAppState({required UserRepository userRepository}) : _userRepository = userRepository;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mobile  Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocBuilder<AuthenticationBloc, AuthenticationState> (builder: (context, state) {
          if(state is AuthenticationFailure) {
            return Scaffold(
                appBar: AppBar(),
                body: Container(
                    child:
                  LoginScreen(userRepository: _userRepository,),
                ));
          }
          if(state is AuthenticationSuccess) {
            return HomeAfterScreen(
              user: state.firebaseUser,
            );
          }
          return Scaffold(
            appBar: AppBar(),
            body: Container(
              child:
              Container(color: Colors.white,)
              //LoginScreen(userRepository: _userRepository,),
            ),
          );
        },
        ));
  }
}
