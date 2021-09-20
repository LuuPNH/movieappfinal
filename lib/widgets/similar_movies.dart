import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movieappfinal/bloc/get_movie_similar_bloc.dart';
import 'package:movieappfinal/model/movie.dart';
import 'package:movieappfinal/model/movie_response.dart';
import 'package:movieappfinal/style/theme.dart' as Style;

class SimilarMovies extends StatefulWidget {
  final int id;
  SimilarMovies({Key? key, required this.id}) : super(key: key);
  @override
  _SimilarMoviesState createState() => _SimilarMoviesState(id);
}

class _SimilarMoviesState extends State<SimilarMovies> {
  final int id;
  _SimilarMoviesState(this.id);
  @override
  void initState() {
    super.initState();
    similarMoviesBloc..getSmililarMovies(id);
  }

  @override
  void dispose() {
    similarMoviesBloc..drainStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 20.0),
          child: Text(
            "SIMILAR MOVIES",
            style: TextStyle(
                color: Style.Colors.titleColor,
                fontWeight: FontWeight.w500,
                fontSize: 12.0),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        StreamBuilder<MovieResponse>(
          stream: similarMoviesBloc.subject.stream,
          builder: (context, AsyncSnapshot<MovieResponse> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.error.length > 0) {
                return _buildErrorWidget(snapshot.data!.error);
              }
              return _buildHomeWidget(snapshot.data!);
            } else if (snapshot.hasError) {
              return _buildErrorWidget(snapshot.error.toString());
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

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Error occured: $error"),
      ],
    ));
  }

  Widget _buildHomeWidget(MovieResponse data) {
    List<Movie> movies = data.movies;
    if (movies.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  "No More Movies",
                  style: TextStyle(color: Colors.black45),
                )
              ],
            )
          ],
        ),
      );
    } else
      return Container(
        height: 270.0,
        padding: EdgeInsets.only(left: 10.0),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 15.0),
              child: GestureDetector(
                onTap: () {},
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Hero(
                      tag: movies[index].id,
                      child: Container(
                          width: 120.0,
                          height: 180.0,
                          decoration: new BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(2.0)),
                            shape: BoxShape.rectangle,
                            image: new DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    "https://image.tmdb.org/t/p/w200/" +
                                        movies[index].poster)),
                          )),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      width: 100,
                      child: Text(
                        movies[index].title,
                        maxLines: 2,
                        style: TextStyle(
                            height: 1.4,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 11.0),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          (movies[index].rating / 2).toString().substring(0, 3),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        RatingBar.builder(
                          itemSize: 8.0,
                          initialRating: movies[index].rating / 2,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                          itemBuilder: (context, _) => Icon(
                            EvaIcons.star,
                            color: Style.Colors.secondColor,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      );
  }
}
