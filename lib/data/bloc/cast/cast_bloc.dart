import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moviesapp/data/model/CastResponse/cast_response.dart';
import 'package:moviesapp/data/repository/AppRepository.dart';

part 'cast_event.dart';

part 'cast_state.dart';

class CastBloc extends Bloc<CastEvent, CastState> {
  AppRepository _repository = AppRepository();

  @override
  CastState get initialState => InitialCastState();

  @override
  Stream<CastState> mapEventToState(CastEvent event) async* {
    if (event is GetCasts) {
      yield CastLoading();
      CastResponse castResponse = await _repository.getCasts(event.id);
      if (castResponse == null) {
        yield CastLoadError();
      } else {
        yield CastLoaded(castResponse);
      }
    }
  }
}
