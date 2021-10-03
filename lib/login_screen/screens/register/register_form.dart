import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:movieappfinal/style/Button_form.dart';
import 'package:movieappfinal/style/theme.dart' as Style;


class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
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
                  labelText: 'Passowrd',
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
                  hintText: 'Confirm password',
                  hintStyle: TextStyle(color: Style.Colors.text),
                  labelText: 'Confirm password',
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


            ButtonForm(
              height: 40.0,
              width: MediaQuery.of(context).size.width * 0.5,
              colorButton: Style.Colors.secondColor,
              titleButton: "Register",
              function: (){},
            ),
          ],
        ),
      ),
    );
  }
}

