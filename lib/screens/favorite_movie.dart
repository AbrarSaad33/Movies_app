import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moives_app/providers/auth_provider.dart';
import 'package:moives_app/providers/movie.dart';
import 'package:moives_app/widgets/app_drawer.dart';
import 'package:moives_app/widgets/favorite_listView.dart';
import 'package:moives_app/widgets/movie_grid.dart';
import 'package:provider/provider.dart';

class FavoriteMovies extends StatefulWidget {
  static const routeName = '/favorite_movies';

  @override
  _FavoriteMoviesState createState() => _FavoriteMoviesState();
}

class _FavoriteMoviesState extends State<FavoriteMovies> {
  var _showFavoritesOnly = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Favorites Movies'),
      ),
      drawer: AppDrawer(),
      body: FavoriteListView(_showFavoritesOnly),
    );
  }
}
