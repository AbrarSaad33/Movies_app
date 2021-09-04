import 'package:flutter/material.dart';
import 'package:moives_app/providers/movies_provider.dart';
import './movie_item.dart';
import 'package:provider/provider.dart';

class MovieGrid extends StatelessWidget {
  final bool showFavs;
  MovieGrid(this.showFavs);
  @override
  Widget build(BuildContext context) {
    final movieData = Provider.of<MoviesProviders>(context);
    final movies = showFavs ? movieData.favoriteItems : movieData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: movies[i],
        child: MovieItem(),
      ),
      itemCount: movies.length,
    );
  }
}
