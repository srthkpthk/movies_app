part of 'movie_bloc.dart';

@immutable
abstract class MovieEvent {}

class GetMovies extends MovieEvent {}