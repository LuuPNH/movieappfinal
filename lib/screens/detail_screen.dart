import 'package:flutter/material.dart';
import 'package:movieappfinal/bloc/get_movie_videos_bloc.dart';
import 'package:movieappfinal/model/movie.dart';
import 'package:movieappfinal/model/video.dart';
import 'package:movieappfinal/model/video_response.dart';
import 'package:movieappfinal/style/theme.dart' as Style;
import 'package:sliver_fab/sliver_fab.dart';

class MovieDetailScreen extends StatefulWidget {
  final Movie movie;
  MovieDetailScreen({Key? key, required this.movie}) : super(key: key);

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState(movie);
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  final Movie movie;
  _MovieDetailScreenState(this.movie);
  @override
  void initState() {
    super.initState();
    movieVideosBloc.getMoviesVideo(movie.id);
  }

  @override
  void dispose() {
    super.dispose();
    movieVideosBloc.drainStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.Colors.mainColor,
      body: Builder(builder: (context) {
        return SliverFab(
          floatingPosition: FloatingPosition(right: 20.0),
          floatingWidget: StreamBuilder<VideoResponse>(
            stream: movieVideosBloc.subject.stream,
            builder: (context, AsyncSnapshot<VideoResponse> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.error.length > 0) {
                  return _buildErrorWidget();
                }
                return _buildHomeWidget(snapshot.data!);
              } else if (snapshot.hasError) {
                return _buildErrorWidget();
              } else {
                return _buildLoadingWidget();
              }
            },
          ),
          expandedHeight: 200.0,
          slivers: [
            SliverAppBar(
              backgroundColor: Style.Colors.mainColor,
              expandedHeight: 200.0,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  movie.title.length > 40
                      ? movie.title.substring(0, 37) + "..."
                      : movie.title,
                  style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                ),
                background: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://image.tmdb.org/t/p/original/" +
                                      movie.backPoster))),
                      child: Container(
                        decoration:
                            BoxDecoration(color: Colors.black.withOpacity(0.5)),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                            Colors.black.withOpacity(0.9),
                            Colors.black.withOpacity(0.0)
                          ])),
                    )
                  ],
                ),
              ),
            )
          ],
        );
      }),
    );
  }

  Widget _buildLoadingWidget() {
    return Container();
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Column(
        children: [Text("We have error here!")],
      ),
    );
  }

  Widget _buildHomeWidget(VideoResponse data) {
    List<Video> videos = data.videos;
    return FloatingActionButton(
        backgroundColor: Style.Colors.secondColor,
        child: Icon(Icons.play_arrow),
        onPressed: null);
  }
}
