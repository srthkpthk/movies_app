import 'package:flutter/material.dart';
import 'package:moviesapp/data/bloc/movies_by_genre/movies_by_genre_bloc.dart';
import 'package:moviesapp/data/model/GenreResponse/genre.dart';
import 'package:moviesapp/screens/widgets/genre_movies.dart';

class GenresList extends StatefulWidget {
  final List<Genre> genres;

  GenresList({Key key, @required this.genres}) : super(key: key);

  @override
  _GenresListState createState() => _GenresListState(genres);
}

class _GenresListState extends State<GenresList>
    with SingleTickerProviderStateMixin {
  final List<Genre> genres;

  _GenresListState(this.genres);

  TabController _tabController;
  MoviesByGenreBloc _bloc;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: genres.length);
    _bloc = MoviesByGenreBloc();
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _bloc.drain();
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height / 3.2,
        child: DefaultTabController(
          length: genres.length,
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(50.0),
              child: AppBar(
                elevation: 0,
                bottom: TabBar(
                  controller: _tabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorWeight: 3.0,
                  indicatorColor: Colors.white,
                  unselectedLabelColor: Colors.white,
                  labelColor: Colors.white,
                  isScrollable: true,
                  tabs: genres.map((Genre genre) {
                    return Container(
                        padding: EdgeInsets.only(bottom: 15.0, top: 10.0),
                        child: new Text(genre.name,
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            )));
                  }).toList(),
                ),
              ),
            ),
            body: TabBarView(
              controller: _tabController,
              physics: NeverScrollableScrollPhysics(),
              children: genres.map((Genre genre) {
                return GenreMovies(
                  genreId: genre.id,
                );
              }).toList(),
            ),
          ),
        ));
  }
}
