part of 'now_playing_bloc.dart';

@immutable
abstract class NowPlayingState {}

class InitialNowPlayingState extends NowPlayingState {}

class NowPlayingLoading extends NowPlayingState {}

class NowPlayingLoadError extends NowPlayingState {}

class NowPlayingLoaded extends NowPlayingState {
  MovieResponse response;

  NowPlayingLoaded(this.response);
}
