import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moviesapp/data/bloc/now_playing/now_playing_bloc.dart';
import 'package:moviesapp/data/model/MovieResponse/movie.dart';
import 'package:moviesapp/data/model/MovieResponse/movie_response.dart';
import 'package:moviesapp/screens/widgets/common/errorWidget.dart';
import 'package:moviesapp/screens/widgets/common/loadingWidget.dart';
import 'package:page_indicator/page_indicator.dart';

class NowPlaying extends StatefulWidget {
  @override
  _NowPlayingState createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  PageController pageController =
      PageController(viewportFraction: 1, keepPage: true);
  NowPlayingBloc _nowPlayingBloc;

  @override
  void initState() {
    super.initState();
    _nowPlayingBloc = NowPlayingBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _nowPlayingBloc,
      // ignore: missing_return
      builder: (_, NowPlayingState state) {
        if (state is InitialNowPlayingState) {
          _nowPlayingBloc.add(GetNowPlaying());
          return loadingWidget();
        }
        if (state is NowPlayingLoading) {
          return loadingWidget();
        }
        if (state is NowPlayingLoadError) {
          return Column(
            children: <Widget>[
              errorWidget(),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                onPressed: () {
                  _nowPlayingBloc.add(GetNowPlaying());
                },
                child: Text(
                  'Retry ?',
                ),
              )
            ],
          );
        }
        if (state is NowPlayingLoaded) {
          return _nowPLayingWidget(state.response);
        }
      },
    );
  }

  Widget _nowPLayingWidget(MovieResponse data) {
    List<Movie> movies = data.movies;
    if (movies.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  "No More Movies",
                  style: TextStyle(color: Colors.black45),
                )
              ],
            )
          ],
        ),
      );
    } else
      return Container(
        height: MediaQuery.of(context).size.height / 4,
        child: PageIndicatorContainer(
          align: IndicatorAlign.bottom,
          length: movies.take(5).length,
          indicatorSpace: 8.0,
          padding: const EdgeInsets.all(5.0),
          indicatorColor: Colors.grey,
          indicatorSelectorColor: Colors.black,
          shape: IndicatorShape.circle(size: 5.0),
          child: PageView.builder(
            controller: pageController,
            scrollDirection: Axis.horizontal,
            itemCount: movies.take(5).length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GestureDetector(
                  onTap: () {},
                  child: Stack(
                    children: <Widget>[
                      Hero(
                        tag: movies[index].id,
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 4,
                            decoration: new BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(15),
                              image: new DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      "https://image.tmdb.org/t/p/original/" +
                                          movies[index].backPoster)),
                            )),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              stops: [
                                0.0,
                                0.9
                              ],
                              colors: [
                                Colors.white.withOpacity(.20),
                                Colors.white.withOpacity(.30),
                              ]),
                        ),
                      ),
                      Positioned(
                          bottom: 0.0,
                          top: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: Icon(
                            FontAwesomeIcons.play,
                            color: Colors.white,
                            size: 40.0,
                          )),
                      Positioned(
                          bottom: 30.0,
                          child: Container(
                            padding: EdgeInsets.only(left: 10.0, right: 10.0),
                            width: 250.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  movies[index].title,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 35.0),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      );
  }
}
