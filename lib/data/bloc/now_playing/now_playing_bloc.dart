import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moviesapp/data/model/MovieResponse/movie_response.dart';
import 'package:moviesapp/data/repository/AppRepository.dart';

part 'now_playing_event.dart';

part 'now_playing_state.dart';

class NowPlayingBloc extends Bloc<NowPlayingEvent, NowPlayingState> {
  AppRepository _repository = AppRepository();

  @override
  NowPlayingState get initialState => InitialNowPlayingState();

  @override
  Stream<NowPlayingState> mapEventToState(NowPlayingEvent event) async* {
    if (event is GetNowPlaying) {
      yield NowPlayingLoading();
      MovieResponse movieResponse = await _repository.getNowPlayingMovies();
      if (movieResponse == null) {
        yield NowPlayingLoadError();
      } else {
        yield NowPlayingLoaded(movieResponse);
      }
    }
  }
}
