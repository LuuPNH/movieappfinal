import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:movieappfinal/search_movie_screen/search.dart';
import 'package:movieappfinal/style/theme.dart' as Style;
import 'package:movieappfinal/home_screen/genres/genres.dart';
import 'package:movieappfinal/home_screen/slide_now_playing/now_playing.dart';
import 'package:movieappfinal/home_screen/person/persons.dart';
import 'package:movieappfinal/home_screen/top_movies/top_movies.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

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
  ];

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
            onPressed: () {},
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
