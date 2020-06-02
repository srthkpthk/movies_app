import 'package:flutter/material.dart';
import 'package:moviesapp/data/model/MovieResponse/movie.dart';

class MovieDetailScreen extends StatefulWidget {
  Movie movie;

  MovieDetailScreen(this.movie, {Key key}) : super(key: key);

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState(movie);
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  Movie movie;

  _MovieDetailScreenState(this.movie);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: MediaQuery.of(context).size.height * (3 / 4),
                floating: true,
                pinned: false,
                flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                  "https://image.tmdb.org/t/p/original/" + movie.poster,
                  fit: BoxFit.fill,
                )),
              )
            ];
          },
          body: movieDetailScreenBody()),
    );
  }

  Widget movieDetailScreenBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * (3 / 4),
                child: Text(
                  movie.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40.0),
                ),
              ),
              Container(
                child: Text(
                  movie.rating.toString(),
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: ratingColour(movie.rating)),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Overview',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35.0),
              ),
              Column(
                children: [
                  Text('Popularity',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0)),
                  Text(
                    movie.popularity.toString(),
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 35.0),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(
              child: Text(
            movie.overview,
            style: TextStyle(
              fontSize: 18,
            ),
          ))
        ],
      ),
    );
  }

  Color ratingColour(double rating) {
    if (rating > 7) {
      return Colors.green;
    }
    if (rating < 7 && rating > 5) {
      return Colors.yellow;
    }
    if (rating < 5 && rating > 0) {
      return Colors.red;
    }
  }
}
