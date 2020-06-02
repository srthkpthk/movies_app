part of 'video_bloc.dart';

@immutable
abstract class VideoEvent {}

class GetMovieVideo extends VideoEvent {
  int id;

  GetMovieVideo(this.id);
}
