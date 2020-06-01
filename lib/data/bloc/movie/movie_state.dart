part of 'movie_bloc.dart';

@immutable
abstract class MovieState {}

class InitialMovieState extends MovieState {}

class MovieLoading extends MovieState {}

class MovieLoaded extends MovieState {
  MovieResponse response;

  MovieLoaded(this.response);
}

class MovieLoadError extends MovieState {}
