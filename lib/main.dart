import 'package:flutter/material.dart';
import 'package:moviesapp/screens/movies_home.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie Catalog',
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.red,
          fontFamily: 'ProductSans'),
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Colors.grey.shade900,
          primarySwatch: Colors.grey,
          fontFamily: 'ProductSans'),
      home: MoviesHome(),
    );
  }
}
