import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:moives_app/providers/auth_provider.dart';
import '../providers/movie.dart';
import 'package:provider/provider.dart';

class FavoriteItem extends StatefulWidget {
  @override
  FavoriteItemState createState() => FavoriteItemState();
}

class FavoriteItemState extends State<FavoriteItem> {
  @override
  Widget build(BuildContext context) {
    final loadedMovie = Provider.of<Movie>(context, listen: false);
    final authData = Provider.of<Auth>(context);
    return Container(
      margin: EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Column(children: [
          Container(
            child: Image.network(
              'https://image.tmdb.org/t/p/w500' + loadedMovie.image,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return Text('can\'t load image');
              },
              fit: BoxFit.cover,
              width: 200,
              height: 200,
            ),
          ),
          Container(
            child: Text(
              loadedMovie.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Anton'
              ),
              maxLines: 1,
            ),
          ),
        ]),
      ),
    );
  }
}
