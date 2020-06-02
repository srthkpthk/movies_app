import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moviesapp/data/model/MovieResponse/movie_response.dart';
import 'package:moviesapp/data/repository/AppRepository.dart';

part 'movies_by_genre_event.dart';
part 'movies_by_genre_state.dart';

class MoviesByGenreBloc extends Bloc<MoviesByGenreEvent, MoviesByGenreState> {
  AppRepository _repository = AppRepository();

  @override
  MoviesByGenreState get initialState => InitialMoviesByGenreState();

  @override
  Stream<MoviesByGenreState> mapEventToState(MoviesByGenreEvent event) async* {
    if (event is GetMovieByGenre) {
      yield MoviesByGenreLoading();
      MovieResponse movieResponse = await _repository.getMovieByGenre(event.id);
      if (movieResponse == null) {
        yield MoviesByGenreLoadError();
      } else {
        yield MoviesByGenreLoaded(movieResponse);
      }
    }
  }
}
