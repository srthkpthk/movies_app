import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moviesapp/data/model/MovieDetailResponse/movie_detail_response.dart';
import 'package:moviesapp/data/repository/AppRepository.dart';

part 'movie_detail_event.dart';

part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  AppRepository _repository = AppRepository();

  @override
  MovieDetailState get initialState => InitialMovieDetailState();

  @override
  Stream<MovieDetailState> mapEventToState(MovieDetailEvent event) async* {
    if (event is GetMovieDetail) {
      yield MovieDetailLoading();
      MovieDetailResponse movieDetailResponse =
          await _repository.getMovieDetail(event.id);
      if (movieDetailResponse == null) {
        yield MovieDetailLoadError();
      } else {
        yield MovieDetailLoaded(movieDetailResponse);
      }
    }
  }
}
