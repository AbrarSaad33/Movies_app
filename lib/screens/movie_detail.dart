import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:moives_app/providers/movie_provider.dart';
import 'package:provider/provider.dart';

class MovieDetail extends StatefulWidget {
  static const routeName = '/movie_detail';

  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  @override
  Widget build(BuildContext context) {
    final movieId = ModalRoute.of(context)!.settings.arguments as String;
    final loadedMovie = Provider.of<MovieProviders>(context,listen: false).findById(movieId);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            actions: [
              IconButton(
                color: Theme.of(context).accentColor,
                onPressed: () {
                  setState(() {
                    loadedMovie.toggleFavoriteStatus();
                  });
                },
                icon: Icon(loadedMovie.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border),
              ),
            ],
            expandedHeight: 300,
            pinned: true,
            // flexibleSpace: FlexibleSpaceBar(
            //   title: Text(loadedMovie.title),
            //   background: Hero(
            //     tag: loadedMovie.id,
            //     child: Image.network(
            //       'https://image.tmdb.org/t/p/w500'+loadedMovie.image,
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 20),
                Container(
                  alignment: Alignment.center,
                  child: RatingBar.builder(
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 4,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.red,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  child: Text(
                    'OverView :',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    softWrap: true,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  child: Text(
                    loadedMovie.description,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    softWrap: true,
                  ),
                ),
                SizedBox(
                  height: 800,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
