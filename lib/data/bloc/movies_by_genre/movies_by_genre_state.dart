part of 'movies_by_genre_bloc.dart';

@immutable
abstract class MoviesByGenreState {}

class InitialMoviesByGenreState extends MoviesByGenreState {}

class MoviesByGenreLoading extends MoviesByGenreState {}

class MoviesByGenreLoadError extends MoviesByGenreState {}

class MoviesByGenreLoaded extends MoviesByGenreState {
  MovieResponse response;

  MoviesByGenreLoaded(this.response);
}
