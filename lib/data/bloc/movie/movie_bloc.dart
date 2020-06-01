import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moviesapp/data/model/MovieResponse/movie_response.dart';
import 'package:moviesapp/data/repository/AppRepository.dart';

part 'movie_event.dart';

part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  AppRepository _repository = AppRepository();

  @override
  MovieState get initialState => InitialMovieState();

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {
    if (event is GetMovies) {
      yield MovieLoading();
      MovieResponse movieResponse = await _repository.getMovies();
      if (movieResponse == null) {
        yield MovieLoadError();
      } else {
        yield MovieLoaded(movieResponse);
      }
    }
  }
}
