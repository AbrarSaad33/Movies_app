import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:moives_app/providers/auth_provider.dart';
import 'package:moives_app/providers/movies_provider.dart';
import '../providers/movie_provider.dart';
import '../screens/movie_detailsScreen.dart';
import 'package:provider/provider.dart';

class MovieItem extends StatefulWidget {
  @override
  _MovieItemState createState() => _MovieItemState();
}

class _MovieItemState extends State<MovieItem> {
  @override
  Widget build(BuildContext context) {
    final loadedMovie = Provider.of<Movie>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);
   // final movie = Provider.of<MoviesProviders>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(MovieDetail.routeName, arguments: loadedMovie.id);
          },
          child: Container(
            child: Image.network(
              'https://image.tmdb.org/t/p/w500' + loadedMovie.image,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return Text('can\'t load image');
              },
              fit: BoxFit.cover,
            ),
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Movie>(
            builder: (ctx, mov, child) => IconButton(
              color: Theme.of(context).accentColor,
              onPressed: () {
                print(loadedMovie.isFavorite);
                loadedMovie.toggleFavoriteStatus(
                   authData.userId,authData.token);
                     print(loadedMovie.isFavorite);
              },
              icon: Icon(
                loadedMovie.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.white,
              ),
            ),
          ),
          title: Container(
            child: Text(
              loadedMovie.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
              ),
              maxLines: 1,
            ),
          ),
        ),
      ),
    );
  }
}
