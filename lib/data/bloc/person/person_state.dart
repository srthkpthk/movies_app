part of 'person_bloc.dart';

@immutable
abstract class PersonState {}

class InitialPersonState extends PersonState {}
class PersonLoading extends PersonState {}
class PersonLoadError extends PersonState {}
class PersonLoaded extends PersonState {
  PersonResponse response;

  PersonLoaded(this.response);
}