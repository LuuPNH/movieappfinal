import 'package:flutter/cupertino.dart';
import 'package:movieappfinal/model/cast_response.dart';
import 'package:movieappfinal/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class CastsBloc {
  final MovieRepository _repository = MovieRepository();
   BehaviorSubject<CastResponse> _subject =
      BehaviorSubject<CastResponse>();

  getCasts(int id) async {
    CastResponse response = await _repository.getCasts(id);
    _subject.sink.add(response);
  }

  void drainStream() {
    _subject =  BehaviorSubject<CastResponse>();
  }

  @mustCallSuper
  void dispose() async {
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<CastResponse> get subject => _subject;
}

final castsBloc = CastsBloc();
