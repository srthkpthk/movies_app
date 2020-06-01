part of 'similar_movies_bloc.dart';

@immutable
abstract class SimilarMoviesEvent {}

class GetSimilarMovies extends SimilarMoviesEvent {
  int id;

  GetSimilarMovies(this.id);
}
