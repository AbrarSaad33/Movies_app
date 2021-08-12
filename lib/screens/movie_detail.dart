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
    final loadedMovie =
        Provider.of<MovieProviders>(context, listen: false).findById(movieId);
    return Scaffold(
      //backgroundColor: Theme.of(context).accentColor,
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
            flexibleSpace: FlexibleSpaceBar(
              title: Text(loadedMovie.title),
              background: Hero(
                tag: loadedMovie.id,
                child: Image.network(
                  'https://image.tmdb.org/t/p/w500' + loadedMovie.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                          icon: Icon(
                            Icons.star_purple500_outlined,
                            color: Colors.amber,
                          ),
                          onPressed: () {},
                        )),
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Text(loadedMovie.rate.toString()),
                      alignment: Alignment.bottomRight,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
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
                     // fontWeight: FontWeight.normal,
                      fontFamily:'Anton',
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
