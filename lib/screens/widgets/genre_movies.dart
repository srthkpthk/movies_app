import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviesapp/data/bloc/movies_by_genre/movies_by_genre_bloc.dart';
import 'package:moviesapp/data/model/MovieResponse/movie.dart';
import 'package:moviesapp/data/model/MovieResponse/movie_response.dart';
import 'package:moviesapp/screens/widgets/common/loadingWidget.dart';

import 'common/errorWidget.dart';

class GenreMovies extends StatefulWidget {
  final int genreId;

  GenreMovies({Key key, @required this.genreId}) : super(key: key);

  @override
  _GenreMoviesState createState() => _GenreMoviesState(genreId);
}

class _GenreMoviesState extends State<GenreMovies> {
  final int genreId;

  _GenreMoviesState(this.genreId);

  MoviesByGenreBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = MoviesByGenreBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _bloc,
      // ignore: missing_return
      builder: (_, MoviesByGenreState state) {
        if (state is InitialMoviesByGenreState) {
          _bloc.add(GetMovieByGenre(genreId));
          return loadingWidget();
        }
        if (state is MoviesByGenreLoading) {
          return loadingWidget();
        }
        if (state is MoviesByGenreLoadError) {
          return Column(
            children: <Widget>[
              errorWidget(),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                onPressed: () {
                  _bloc.add(GetMovieByGenre(genreId));
                },
                child: Text(
                  'Retry ?',
                ),
              )
            ],
          );
        }
        if (state is MoviesByGenreLoaded) {
          return _moviesByGenre(state.response);
        }
      },
    );
  }

  Widget _moviesByGenre(MovieResponse data) {
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
//        height: MediaQuery.of(context).size.height / 4,
        padding: EdgeInsets.only(left: 10.0),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 15.0),
              child: GestureDetector(
//                onTap: () {
//                  Navigator.push(
//                    context,
//                    MaterialPageRoute(
//                      builder: (context) =>
//                     MovieDetailScreen(movie: movies[index]),
//                    ),
//                  );
//                },
                //todo
                onTap: () {},
                child: Column(
                  children: <Widget>[
                    movies[index].poster == null
                        ? Container(
                            width: 120.0,
                            height: 180.0,
                            decoration: new BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2.0)),
                              shape: BoxShape.rectangle,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  EvaIcons.filmOutline,
                                  color: Colors.white,
                                  size: 60,
                                )
                              ],
                            ),
                          )
                        : Stack(
                            children: [
                              Container(
                                  width: 120.0,
                                  height: 180.0,
                                  decoration: new BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    shape: BoxShape.rectangle,
                                    image: new DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            "https://image.tmdb.org/t/p/w200/" +
                                                movies[index].poster)),
                                  )),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 10),
                                child: Row(
                                  children: [
                                    Text(
                                      movies[index]
                                          .rating
                                          .toString()
                                          .substring(0, 1)
                                          .toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      movies[index]
                                          .rating
                                          .toString()
                                          .substring(1)
                                          .toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 5),
                        width: 100,
                        child: Text(
                          movies[index].title,
                          maxLines: 2,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      );
  }
}
