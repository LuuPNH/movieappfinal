import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:movieappfinal/style/theme.dart' as Style;


class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordlController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  hintText: 'Enter your email',
                  hintStyle: TextStyle(color: Style.Colors.text),
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Style.Colors.secondColor),
                  icon: Icon(EvaIcons.email, color: Style.Colors.secondColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: const BorderSide(color: Style.Colors.secondColor, width: 1.0)
                  )
                ),
              ),
            SizedBox(
              height: 5.0,
            ),
            //password
            TextFormField(
              controller: passwordlController,
              style: TextStyle(color: Style.Colors.text),
              decoration: InputDecoration(

                  hintText: 'Enter your password',
                  hintStyle: TextStyle(color: Style.Colors.text),
                  labelText: 'Passowrd',
                  labelStyle: TextStyle(color: Style.Colors.secondColor),
                  icon: Icon(EvaIcons.lock, color: Style.Colors.secondColor),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: const BorderSide(color: Style.Colors.secondColor, width: 1.0)
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
}

