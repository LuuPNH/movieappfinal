import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieappfinal/login_screen/authentication_bloc/authentication_bloc.dart';
import 'package:movieappfinal/login_screen/authentication_bloc/authentication_event.dart';
import 'package:movieappfinal/login_screen/register_bloc/register_bloc.dart';
import 'package:movieappfinal/login_screen/register_bloc/register_event.dart';
import 'package:movieappfinal/login_screen/register_bloc/register_state.dart';
import 'package:movieappfinal/repository/user_repository.dart';
import 'package:movieappfinal/style/Button_form.dart';
import 'package:movieappfinal/style/theme.dart' as Style;


class RegisterForm extends StatefulWidget {
  final UserRepository _userRepository;

  const RegisterForm({Key? key, required UserRepository userRepository}) :_userRepository = userRepository, super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordlController = TextEditingController();

  bool get isPopulated => emailController.text.isNotEmpty && passwordlController.text.isNotEmpty;

  bool isButtonEnable(RegisterState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting!;
  }

  late RegisterBloc registerBloc;
  @override
  void initState() {
    super.initState();
    registerBloc = BlocProvider.of<RegisterBloc>(context);
    emailController.addListener(_onEmailChange);
    passwordlController.addListener(_onPasswordChange);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if(state.isFailure!) {
          Scaffold.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
                SnackBar(
                    backgroundColor: Style.Colors.secondColor,
                    content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Register Failure! Please again"),
                          Icon(Icons.error)
                        ])));
        }
        if(state.isSubmitting!) {
          Scaffold.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
                SnackBar(
                    backgroundColor: Style.Colors.secondColor,
                    content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Registering..."),
                          CircularProgressIndicator()]
                    )));
        }
        if(state.isSuccess!) {
          BlocProvider.of<AuthenticationBloc>(context).add(
            AuthenticatonLoggedIn(),
          );
          Navigator.pop(context);
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              child: Column(
                children: [
                  //email
                  TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      style: TextStyle(color: Style.Colors.text),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(width: 1,color: Style.Colors.secondColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(width: 1,color: Style.Colors.secondColor),
                        ),
                        hintText: 'Enter your email',
                        hintStyle: TextStyle(color: Style.Colors.text),
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Style.Colors.secondColor),
                        icon: Icon(EvaIcons.email, color: Style.Colors.secondColor),
                      )
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
                          borderSide: BorderSide(width: 1,color: Style.Colors.secondColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(width: 1,color: Style.Colors.secondColor),
                        ),
                        hintText: 'Enter your password',
                        hintStyle: TextStyle(color: Style.Colors.text),
                        labelText: 'Passoword',
                        labelStyle: TextStyle(color: Style.Colors.secondColor),
                        icon: Icon(EvaIcons.lock, color: Style.Colors.secondColor),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: const BorderSide(color: Style.Colors.secondColor, width: 1.0)
                        )
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  //confirm password
                  SizedBox(
                    height: 5.0,
                  ),
                  ButtonForm(
                    height: 40.0,
                    width: MediaQuery.of(context).size.width * 0.5,
                    colorButton: Style.Colors.secondColor,
                    titleButton: "Register",
                    function: (){
                      if(isButtonEnable(state)){
                      _onFormSubmitted();
                      }}
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("You have a account?", style: TextStyle(color: Style.Colors.text)),
                      TextButton(
                        onPressed: () { Navigator.pop(context);},
                        child: const Text('Singin', style: TextStyle(color: Style.Colors.secondColor)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        } ,
      ),
    );
  }
  void _onEmailChange() {
    registerBloc.add(RegisterEmailChanged(email: emailController.text));
  }

  void _onPasswordChange() {
    registerBloc.add(RegisterPasswordChanged(password: passwordlController.text));
  }
  void _onFormSubmitted() {
    registerBloc.add(RegisterSubmitted(email: emailController.text,password: passwordlController.text));
  }
  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordlController.dispose();
    super.dispose();
  }
}

