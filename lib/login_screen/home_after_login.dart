import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieappfinal/login_screen/authentication_bloc/authentication_bloc.dart';
import 'package:movieappfinal/login_screen/authentication_bloc/authentication_event.dart';

class HomeAfterScreen extends StatelessWidget {
  final FirebaseAuth user;

  const HomeAfterScreen({Key? key, required this.user}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context)
                  .add(AuthenticatonLoggedOut());
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: Text("Hello, ${user.currentUser!.email}"),
          ),
        ],
      ),
    );
  }
}