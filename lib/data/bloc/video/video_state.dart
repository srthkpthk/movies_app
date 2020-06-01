part of 'video_bloc.dart';

@immutable
abstract class VideoState {}

class InitialVideoState extends VideoState {}

class MovieVideoLoading extends VideoState {}

class MovieVideoLoadError extends VideoState {}

class MovieVideoLoaded extends VideoState {
  VideoResponse _response;

  MovieVideoLoaded(this._response);
}
