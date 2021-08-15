import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moives_app/widgets/app_drawer.dart';
import 'package:moives_app/widgets/movie_grid.dart';

class FavoriteMovies extends StatelessWidget {
   static const routeName = '/favorite_movies';
  var _showFavoritesOnly = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Favorites Movies'),
      ),
      drawer: AppDrawer(),
      body: MovieGrid(_showFavoritesOnly),
    );
  }
}
