import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieappfinal/login_screen/login_bloc/login_bloc.dart';
import 'package:movieappfinal/login_screen/register_bloc/register_bloc.dart';
import 'package:movieappfinal/login_screen/register_bloc/register_state.dart';
import 'package:movieappfinal/login_screen/screens/register/register_form.dart';
import 'package:movieappfinal/login_screen/widgets/curved_widget.dart';
import 'package:movieappfinal/repository/user_repository.dart';
import 'package:movieappfinal/style/theme.dart' as Style;

class RegisterScreen extends StatelessWidget {


  const RegisterScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Style.Colors.mainColor,
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  },
                icon: Icon(
              EvaIcons.arrowBack,
              color:  Style.Colors.btnColor,
            ));
          },
        ),
        title: Text("Movie App")),
      body: BlocProvider<RegisterBloc>(
        create: (context) => RegisterBloc(),
        child: Container(
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
                    child:Text("Register", style: TextStyle(color: Colors.white, fontSize: 40.0, fontWeight: FontWeight.bold),),
                  ), ),
                  Container(
                    margin: const EdgeInsets.only(top: 200.0),
                    child: RegisterForm(),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}