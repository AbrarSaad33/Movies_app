import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moives_app/widgets/favorite_listView.dart';

class FavoriteMovies extends StatefulWidget {
  static const routeName = '/favorite_movies';

  @override
  _FavoriteMoviesState createState() => _FavoriteMoviesState();
}

class _FavoriteMoviesState extends State<FavoriteMovies> {
  var _showFavoritesOnly = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Favorites Movies'),
      ),
      // drawer: AppDrawer(),
      body:  FavoriteListView(_showFavoritesOnly),
    );
  }
}
