part of 'cast_bloc.dart';

@immutable
abstract class CastState {}

class InitialCastState extends CastState {}

class CastLoadError extends CastState {}

class CastLoading extends CastState {}

class CastLoaded extends CastState {
  CastResponse response;

  CastLoaded(this.response);
}
