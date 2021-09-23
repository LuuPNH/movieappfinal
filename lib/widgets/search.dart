import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movieappfinal/bloc/get_movie_sugesstion.dart';
import 'package:movieappfinal/model/movie.dart';
import 'package:movieappfinal/model/movie_response.dart';
import 'package:movieappfinal/screens/detail_screen.dart';
import 'package:movieappfinal/style/inputfiled.dart';
import 'package:movieappfinal/style/theme.dart' as Style;

class SearchMovieWidget extends StatefulWidget {
  const SearchMovieWidget({Key? key}) : super(key: key);

  @override
  _SearchMovieWidgetState createState() => _SearchMovieWidgetState();
}

class _SearchMovieWidgetState extends State<SearchMovieWidget> {
  TextEditingController textEditingController = TextEditingController();
  String searchNull = "khongcogi";
  @override
  void initState() {
    super.initState();
    moviesSearchBloc.getMoviesSearch(searchNull);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10.0, top: 20.0),
          child: Column(children: [
            TextFieldContainer(
              color: Style.Colors.titleColor,
              child: TextField(
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0),
                onChanged: (text) {
                  Future.delayed(Duration(milliseconds: 500));
                  if (text.isEmpty == false) {
                    moviesSearchBloc.getMoviesSearch(text);
                    searchNull = text;
                  }
                },
                controller: textEditingController,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  suffixIcon: Icon(
                    EvaIcons.searchOutline,
                    color: Style.Colors.secondColor,
                  ),
                  hintText: 'Enter Your Name',
                  hintStyle: TextStyle(
                      color: Style.Colors.secondColor,
                      height: 1.5,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0),
                  border: InputBorder.none,
                ),
              ),
            ),
          ]),
        ),
        SizedBox(
          height: 5.0,
        ),
        StreamBuilder<MovieResponse>(
          stream: moviesSearchBloc.subject.stream,
          builder: (context, AsyncSnapshot<MovieResponse> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.error.length > 0) {
                return _buildErrorWidget(searchNull);
              }
              return _buildHomeWidget(snapshot.data!);
            } else if (snapshot.hasError) {
              return _buildErrorWidget(searchNull);
            } else {
              return _buildLoadingWidget();
            }
          },
        )
      ],
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 25.0,
          width: 25.0,
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
            strokeWidth: 4.0,
          ),
        )
      ],
    ));
  }

  Widget _buildErrorWidget(String? nameNull) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [],
    ));
  }

  Widget _buildHomeWidget(MovieResponse data) {
    final List<Movie>? movies = data.movies;
    if (movies!.isEmpty) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: [
                Text(
                  (() {
                    if (searchNull == "khongcogi") {
                      return "What is your find?";
                    }
                    return "Can't find this name";
                  })(),
                  style: TextStyle(
                      color: Style.Colors.secondColor,
                      height: 1.5,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0),
                ),
              ],
            )
          ],
        ),
      );
    } else {
      return Container(
        height: 500.0,
        padding: EdgeInsets.only(left: 10.0),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.only(top: 10.0, right: 8.0),
              width: 100.0,
              child: GestureDetector(
                onTap: () async {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MovieDetailScreen(
                                movie: movies[index],
                              )));
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    movies[index].backPoster == null
                        ? Hero(
                            tag: movies[index].id!,
                            child: Container(
                              margin: EdgeInsets.only(left: 25.0, top: 10.0),
                              width: 40.0,
                              height: 40.0,
                              decoration: new BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: Style.Colors.secondColor),
                              child: Icon(
                                FontAwesomeIcons.userAlt,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : Hero(
                            tag: movies[index].id!,
                            child: Container(
                                margin: EdgeInsets.only(left: 25.0),
                                width: 40.0,
                                height: 40.0,
                                decoration: new BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  image: new DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          "https://image.tmdb.org/t/p/w300/" +
                                              movies[index].backPoster!)),
                                )),
                          ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 25.0),
                        child: Text(
                          movies[index].title!,
                          maxLines: 2,
                          style: TextStyle(
                              height: 1.4,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 3.0,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }
  }
}
