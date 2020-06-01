import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:moviesapp/screens/widgets/MoviesGenres.dart';
import 'package:moviesapp/screens/widgets/best_movies.dart';
import 'package:moviesapp/screens/widgets/now_playing_widget.dart';
import 'package:moviesapp/screens/widgets/person_List.dart';

class MoviesHome extends StatefulWidget {
  MoviesHome({Key key}) : super(key: key);

  @override
  _MoviesHomeState createState() => _MoviesHomeState();
}

class _MoviesHomeState extends State<MoviesHome> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          'FILMS',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 35,
              fontStyle: FontStyle.italic),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Now Playing',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              NowPlaying(),
              SizedBox(
                height: 10,
              ),
              Text(
                'Movies',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
              GenresScreen(),
              SizedBox(
                height: 10,
              ),
              Text(
                'Popular Peoples',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
              PersonsList(),
              SizedBox(
                height: 10,
              ),
              Text(
                'Best Movies',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
              BestMovies()
            ],
          ),
        ),
      ),
    );
  }
}
