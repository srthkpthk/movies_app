import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moviesapp/data/model/VideoResponse/video_response.dart';
import 'package:moviesapp/data/repository/AppRepository.dart';

part 'video_event.dart';

part 'video_state.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  AppRepository _repository = AppRepository();

  @override
  VideoState get initialState => InitialVideoState();

  @override
  Stream<VideoState> mapEventToState(VideoEvent event) async* {
    if (event is GetMovieVideo) {
      yield MovieVideoLoading();
      VideoResponse videoResponse = await _repository.getMovieVideos(event.id);
      if (videoResponse == null) {
        yield MovieVideoLoadError();
      } else {
        yield MovieVideoLoaded(videoResponse);
      }
    }
  }
}
