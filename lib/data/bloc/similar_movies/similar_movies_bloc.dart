import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moviesapp/data/model/MovieResponse/movie_response.dart';
import 'package:moviesapp/data/repository/AppRepository.dart';

part 'similar_movies_event.dart';
part 'similar_movies_state.dart';

class SimilarMoviesBloc extends Bloc<SimilarMoviesEvent, SimilarMoviesState> {
  AppRepository _repository = AppRepository();

  @override
  SimilarMoviesState get initialState => InitialSimilarMoviesState();

  @override
  Stream<SimilarMoviesState> mapEventToState(SimilarMoviesEvent event) async* {
    if (event is GetSimilarMovies) {
      yield SimilarMoviesLoading();
      MovieResponse movieResponse =
          await _repository.getSimilarMovies(event.id);
      if (movieResponse == null) {
        yield SimilarMoviesLoadError();
      } else {
        yield SimilarMoviesLoaded(movieResponse);
      }
    }
  }
}
