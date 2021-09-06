import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moives_app/widgets/favorite_listView.dart';

class FavoriteMovieScreen extends StatefulWidget {
  static const routeName = '/favorite_movies';

  @override
 _FavoriteMovieScreenState  createState() => _FavoriteMovieScreenState ();
}

class _FavoriteMovieScreenState  extends State<FavoriteMovieScreen > {
  var _showFavoritesOnly = true;

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
