import 'package:flutter/cupertino.dart';
import 'package:movieappfinal/model/video_response.dart';
import 'package:movieappfinal/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class MovieVideosBloc {
  final MovieRepository _repository = MovieRepository();
   BehaviorSubject<VideoResponse> _subject =
      BehaviorSubject<VideoResponse>();

  getMoviesVideo(int id) async {
    VideoResponse response = await _repository.getMoviesVideos(id);
    _subject.sink.add(response);
  }

  void drainStream() {
    _subject =  BehaviorSubject<VideoResponse>();
  }

  @mustCallSuper
  void dispose() async {
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<VideoResponse> get subject => _subject;
}

final movieVideosBloc = MovieVideosBloc();
