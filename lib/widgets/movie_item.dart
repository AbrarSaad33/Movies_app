import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../providers/movie.dart';
import '../screens/movie_detail.dart';
import 'package:provider/provider.dart';

class MovieItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loadedMovie = Provider.of<Movie>(context,listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(MovieDetail.routeName, arguments: loadedMovie.id);
          },
          child:Image.network('https://image.tmdb.org/t/p/w500'+loadedMovie.image, 
            fit: BoxFit.cover,
          
        ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Movie>(
            builder: (ctx,mov,child)=>IconButton(
              color: Theme.of(context).accentColor,
              onPressed: () {
                loadedMovie.toggleFavoriteStatus();
              },
              icon: Icon(loadedMovie.isFavorite
                  ? Icons.favorite
                  : Icons.favorite_border),
            ),
            
          ),
          title: Text(
            loadedMovie.title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
