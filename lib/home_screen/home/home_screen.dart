import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:movieappfinal/search_movie_screen/search.dart';
import 'package:movieappfinal/style/theme.dart' as Style;
import 'package:movieappfinal/home_screen/genres/genres.dart';
import 'package:movieappfinal/home_screen/slide_now_playing/now_playing.dart';
import 'package:movieappfinal/home_screen/person/persons.dart';
import 'package:movieappfinal/home_screen/top_movies/top_movies.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openEndDrawer() {
    _scaffoldKey.currentState!.openEndDrawer();
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
              ))
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
      body: ListView(
        children: <Widget>[
          NowPlaying(),
          GenresScreen(),
          PersonsList(),
          TopMovies(),
        ],
      ),
    );
  }
}
