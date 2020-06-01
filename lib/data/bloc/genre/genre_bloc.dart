import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moviesapp/data/model/GenreResponse/genre_response.dart';
import 'package:moviesapp/data/repository/AppRepository.dart';

part 'genre_event.dart';

part 'genre_state.dart';

class GenreBloc extends Bloc<GenreEvent, GenreState> {
  AppRepository _repository = AppRepository();

  @override
  GenreState get initialState => InitialGenreState();

  @override
  Stream<GenreState> mapEventToState(GenreEvent event) async* {
    if (event is GetGenres) {
      yield GenreLoading();
      GenreResponse genreResponse = await _repository.getGenres();
      if (genreResponse == null) {
        yield GenreLoadError();
      } else {
        yield GenreLoaded(genreResponse);
      }
    }
  }
}
