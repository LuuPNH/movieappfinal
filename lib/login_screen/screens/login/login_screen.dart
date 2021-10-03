import 'package:flutter/material.dart';
import 'package:movieappfinal/login_screen/screens/login/login_form.dart';
import 'package:movieappfinal/login_screen/widgets/curved_widget.dart';
import 'package:movieappfinal/style/theme.dart' as Style;

class LoginScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF151C26), Color(0xFF151C26)]
          )
        ),
        child: SingleChildScrollView(
          child: Stack(
            children: [ CurvedWidget(
              curvedHeight: 80.0,
              curvedDistance: 80.0,
              child: Container(
                padding: EdgeInsets.only(top: 70.0, left: 50.0),
                width: double.infinity,
                height: 270.0,
                color: Style.Colors.secondColor,
                child:Text("Login", style: TextStyle(color: Colors.white, fontSize: 40.0, fontWeight: FontWeight.bold),),
              ), ),
              Container(
                margin: const EdgeInsets.only(top: 200.0),
                child: LoginForm(),
              )
          ]),
        ),
    );
  }
}