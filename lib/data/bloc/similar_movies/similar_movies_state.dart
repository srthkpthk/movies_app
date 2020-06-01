part of 'similar_movies_bloc.dart';

@immutable
abstract class SimilarMoviesState {}

class InitialSimilarMoviesState extends SimilarMoviesState {}
class SimilarMoviesLoading extends SimilarMoviesState {}
class SimilarMoviesLoadError extends SimilarMoviesState {}
class SimilarMoviesLoaded extends SimilarMoviesState {
  MovieResponse _response;

  SimilarMoviesLoaded(this._response);
}