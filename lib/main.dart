import 'dart:ffi';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieappfinal/home_screen/home/home_screen.dart';
import 'package:movieappfinal/profile/simple_bloc_obsever.dart';

import 'local_data_manager/local_data_manager.dart';
import 'profile/login/login_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  Firebase.initializeApp();
  await LocalDataManager.getInstance();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LocalDataManager.localDataManager?.user != null
          ? HomeScreen()
          : LoginWidget(),
    );
  }
}
