import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieappfinal/login_screen/authentication_bloc/authentication_bloc.dart';
import 'package:movieappfinal/login_screen/authentication_bloc/authentication_event.dart';
import 'package:movieappfinal/login_screen/authentication_bloc/authentication_state.dart';
import 'package:movieappfinal/login_screen/screens/login/login_screen.dart';
import 'package:movieappfinal/repository/user_repository.dart';
import 'package:movieappfinal/search_movie_screen/search.dart';
import 'package:movieappfinal/style/theme.dart' as Style;
import 'package:movieappfinal/home_screen/genres/genres.dart';
import 'package:movieappfinal/home_screen/slide_now_playing/now_playing.dart';
import 'package:movieappfinal/home_screen/person/persons.dart';
import 'package:movieappfinal/home_screen/top_movies/top_movies.dart';

class HomeScreen extends StatefulWidget {
  final UserRepository userRepository;

  HomeScreen({Key? key, required UserRepository userRepository})
      : userRepository = userRepository,
        super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int selectedIndex = 0;
  List<Widget> widgetOptions = <Widget>[
    ListView(children: <Widget>[
      NowPlaying(),
      GenresScreen(),
      PersonsList(),
      TopMovies(),
    ]),
    BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
        if(state is AuthenticationFailure) {
        return LoginScreen();
      }
      if (state is AuthenticationSuccess) {
        return Container(color: Colors.red);
      }
      return Scaffold(
          appBar: AppBar(),
          body: Container(
              child: Container(
            color: Colors.blue,
          )
              //LoginScreen(userRepository: _userRepository,),
              ));
    })
  ];

  // void _sendDataBack(BuildContext context) {
  //   Navigator.pop(context, _userRepository);
  // }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void _openEndDrawer() {
    _scaffoldKey.currentState!.openEndDrawer();
  }

  @override
  void initState() {
    // BlocProvider(
    //   create: (context) => AuthenticationBloc(_userRepository)..add(AuthenticatonStarted()),
    // );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Style.Colors.mainColor,
      appBar: AppBar(
        backgroundColor: Style.Colors.mainColor,
        centerTitle: true,
        leading: Icon(
          EvaIcons.menu2Outline,
          color: Colors.white,
        ),
        title: Text("Movie App"),
        actions: <Widget>[
          IconButton(
              onPressed: _openEndDrawer,
              icon: Icon(
                EvaIcons.searchOutline,
                color: Colors.white,
              )),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context)
                  .add(AuthenticatonLoggedOut());
            },
          )
        ],
      ),
      endDrawer: Drawer(
        child: SafeArea(
          child: Container(
            color: Style.Colors.mainColor,
            padding: EdgeInsets.all(16),
            child: SearchMovieWidget(),
          ),
        ),
      ),
      endDrawerEnableOpenDragGesture: false,
      body: Container(
        child: widgetOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: 'Business',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Style.Colors.secondColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
