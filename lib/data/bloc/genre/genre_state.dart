part of 'genre_bloc.dart';

@immutable
abstract class GenreState {}

class InitialGenreState extends GenreState {}

class GenreLoading extends GenreState {}

class GenreLoaded extends GenreState {
  GenreResponse response;

  GenreLoaded(this.response);
}

class GenreLoadError extends GenreState {}