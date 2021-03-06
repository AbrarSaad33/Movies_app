import 'package:flutter/material.dart';
import 'package:moives_app/providers/movies_provider.dart';
import 'package:moives_app/widgets/favorite_item.dart';
import 'package:provider/provider.dart';

class FavoriteListView extends StatelessWidget {
  final bool showFavs;
  FavoriteListView(this.showFavs);
  @override
  Widget build(BuildContext context) {
    final movieData = Provider.of<MoviesProviders>(context);
    final movies = showFavs ? movieData.favoriteItems : movieData.items;
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: movies[i],
        child: FavoriteItem(),
      ),
      itemCount: movies.length,
    );
  }
}
