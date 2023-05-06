import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieappfinal/home_screen/home/home_screen.dart';
import 'package:movieappfinal/login_screen/authentication_bloc/authentication_bloc.dart';
import 'package:movieappfinal/login_screen/authentication_bloc/authentication_event.dart';
import 'package:movieappfinal/login_screen/login_bloc/login_bloc.dart';
import 'package:movieappfinal/login_screen/login_bloc/login_state.dart';
import 'package:movieappfinal/login_screen/login_bloc/login_event.dart';
import 'package:movieappfinal/login_screen/screens/register/register_screen.dart';
import 'package:movieappfinal/repository/user_repository.dart';
import 'package:movieappfinal/style/Button_form.dart';
import 'package:movieappfinal/style/theme.dart' as Style;

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordlController = TextEditingController();

  bool get isPopulated => emailController.text.isNotEmpty && passwordlController.text.isNotEmpty;

  bool isButtonEnable(LoginState state) {
    return state.isFormValid && isPopulated && !state.isSummiting!;
  }

  late LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    emailController.addListener(_onEmailChange);
    passwordlController.addListener(_onPasswordChange);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(listener: (context, state) {
      if (state.isFailure!) {
        final snackBar = SnackBar(
            backgroundColor: Style.Colors.secondColor,
            content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text("Login Failure! Please again"), Icon(Icons.error)]));
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      if (state.isSummiting!) {
        final snackBar = SnackBar(
            backgroundColor: Style.Colors.secondColor,
            content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text("Logging In..."), CircularProgressIndicator()]));
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      if (state.isSuccess!) {
        print("Success");
        BlocProvider.of<AuthenticationBloc>(context).add(AuthenticatonLoggedIn());
      }
    }, child: BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            child: Column(
              children: [
                //email
                TextFormField(
                  controller: emailController,
                  style: TextStyle(color: Style.Colors.text),
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(width: 1, color: Style.Colors.secondColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(width: 1, color: Style.Colors.secondColor),
                      ),
                      hintText: 'Enter your email',
                      hintStyle: TextStyle(color: Style.Colors.text),
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Style.Colors.secondColor),
                      icon: Icon(EvaIcons.email, color: Style.Colors.secondColor),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide:
                              const BorderSide(color: Style.Colors.secondColor, width: 1.0))),
                  autovalidateMode: AutovalidateMode.always,
                  validator: (_) {
                    return !state.isEmailValid! ? 'Invalid Email' : null;
                  },
                ),
                SizedBox(
                  height: 5.0,
                ),
                //password
                TextFormField(
                  controller: passwordlController,
                  style: TextStyle(color: Style.Colors.text),
                  obscureText: true,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(width: 1, color: Style.Colors.secondColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(width: 1, color: Style.Colors.secondColor),
                      ),
                      hintText: 'Enter your password',
                      hintStyle: TextStyle(color: Style.Colors.text),
                      labelText: 'Passowrd',
                      labelStyle: TextStyle(color: Style.Colors.secondColor),
                      icon: Icon(EvaIcons.lock, color: Style.Colors.secondColor),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide:
                              const BorderSide(color: Style.Colors.secondColor, width: 1.0))),
                  autovalidateMode: AutovalidateMode.always,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Passoword can't empty";
                    } else if (!state.isPasswordVaild!) {
                      return 'Invalid Passoword';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 5.0,
                ),
                //Button
                ButtonForm(
                  height: 40.0,
                  width: MediaQuery.of(context).size.width * 0.5,
                  colorButton: Style.Colors.secondColor,
                  titleButton: "Login",
                  function: () {
                    if (isButtonEnable(state)) {
                      _onFormSubmitted();
                    }
                  },
                ),
                SizedBox(
                  height: 5.0,
                ),

                ButtonForm(
                  height: 40.0,
                  width: MediaQuery.of(context).size.width * 0.5,
                  colorButton: Style.Colors.secondColor,
                  titleButton: "Register",
                  function: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return RegisterScreen();
                    }));
                  },
                ),
              ],
            ),
          ),
        );
      },
    ));
  }

  void _onEmailChange() {
    _loginBloc.add(LoginEmailChange(emailController.text));
  }

  void _onPasswordChange() {
    _loginBloc.add(LoginPasswordChanged(passwordlController.text));
  }

  void _onFormSubmitted() {
    _loginBloc.add(LoginWithCredentialsPressed(emailController.text, passwordlController.text));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordlController.dispose();
    super.dispose();
  }
}
