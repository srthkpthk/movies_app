part of 'movies_by_genre_bloc.dart';

@immutable
abstract class MoviesByGenreEvent {}

class GetMovieByGenre extends MoviesByGenreEvent {
  int id;

  GetMovieByGenre(this.id);
}
