import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieappfinal/home_screen/home/home_screen.dart';
import 'package:movieappfinal/profile/login/login_bloc.dart';
import 'package:movieappfinal/style/theme.dart' as Style;

import '../../resource/app_images.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  late LoginBloc bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = LoginBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => bloc,
      child: MultiBlocListener(
        listeners: [
          BlocListener<LoginBloc, LoginState>(
            listenWhen: (p, c) => p.error != c.error,
            listener: (context, state) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: ${state.error}')));
            },
          ),
          BlocListener<LoginBloc, LoginState>(
            listenWhen: (p, c) => p.user != c.user && c.user != null,
            listener: (context, state) {
              Navigator.pushReplacement<void, void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => HomeScreen(),
                ),
              );
            },
          ),
        ],
        child: Scaffold(
          backgroundColor: Style.Colors.mainColor,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppImages.logoFilm,
                height: 300.0,
                width: 300.0,
                fit: BoxFit.fill,
              ),
              const SizedBox(height: 58.0),
              GestureDetector(
                onTap: () {
                  bloc.add(LoginGGEvent());
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 32.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppImages.iconGoogle,
                          height: 23.0,
                          width: 23.0,
                          fit: BoxFit.fill,
                        ),
                        const SizedBox(width: 16.0),
                        Text('Sign In with Google',
                            maxLines: 1,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            )),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
