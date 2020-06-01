import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moviesapp/data/model/PersonResponse/person_response.dart';
import 'package:moviesapp/data/repository/AppRepository.dart';

part 'person_event.dart';

part 'person_state.dart';

class PersonBloc extends Bloc<PersonEvent, PersonState> {
  AppRepository _repository = AppRepository();

  @override
  PersonState get initialState => InitialPersonState();

  @override
  Stream<PersonState> mapEventToState(PersonEvent event) async* {
    if (event is GetPersons) {
      yield PersonLoading();
      PersonResponse personResponse = await _repository.getPersons();
      if (personResponse == null) {
        yield PersonLoadError();
      } else {
        yield PersonLoaded(personResponse);
      }
    }
  }
}
