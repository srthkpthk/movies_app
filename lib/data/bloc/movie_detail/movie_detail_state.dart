part of 'movie_detail_bloc.dart';

@immutable
abstract class MovieDetailState {}

class InitialMovieDetailState extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailLoaded extends MovieDetailState {
  MovieDetailResponse _response;

  MovieDetailLoaded(this._response);
}

class MovieDetailLoadError extends MovieDetailState {}
