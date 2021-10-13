import 'dart:ffi';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieappfinal/home_screen/home/home_screen.dart';
import 'package:movieappfinal/login_screen/authentication_bloc/authentication_event.dart';
import 'package:movieappfinal/login_screen/simple_bloc_obsever.dart';
import 'package:movieappfinal/repository/user_repository.dart';

import 'login_screen/authentication_bloc/authentication_bloc.dart';

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

  _MyAppState({required UserRepository userRepository}) : _userRepository = userRepository;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(userRepository: _userRepository),
    );
  }
}

