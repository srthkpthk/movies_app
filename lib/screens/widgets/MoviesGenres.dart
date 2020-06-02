import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviesapp/data/bloc/genre/genre_bloc.dart';
import 'package:moviesapp/data/model/GenreResponse/genre.dart';
import 'package:moviesapp/data/model/GenreResponse/genre_response.dart';
import 'package:moviesapp/screens/widgets/common/errorWidget.dart';
import 'package:moviesapp/screens/widgets/common/loadingWidget.dart';
import 'package:moviesapp/screens/widgets/genre_list.dart';

class GenresScreen extends StatefulWidget {
  @override
  _GenresScreenState createState() => _GenresScreenState();
}

class _GenresScreenState extends State<GenresScreen> {
  GenreBloc _genreBloc;

  @override
  void initState() {
    super.initState();
    _genreBloc = GenreBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _genreBloc,
      // ignore: missing_return
      builder: (_, GenreState state) {
        if (state is InitialGenreState) {
          _genreBloc.add(GetGenres());
          return loadingWidget();
        }
        if (state is GenreLoading) {
          return loadingWidget();
        }
        if (state is GenreLoadError) {
          return Column(
            children: <Widget>[
              errorWidget(),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                onPressed: () {
                  _genreBloc.add(GetGenres());
                },
                child: Text(
                  'Retry ?',
                ),
              )
            ],
          );
        }
        if (state is GenreLoaded) {
          return _genreWidget(state.response);
        }
      },
    );
  }

  Widget _genreWidget(GenreResponse data) {
    List<Genre> genres = data.genres;
    print(genres);
    if (genres.length == 0) {
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
      return Padding(
        padding: const EdgeInsets.only(top: 10, left: 10),
        child: GenresList(
          genres: genres,
        ),
      );
  }
}
