part of 'cast_bloc.dart';

@immutable
abstract class CastEvent {}

class GetCasts extends CastEvent {
  int id;

  GetCasts(this.id);
}
