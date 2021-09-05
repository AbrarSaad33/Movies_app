import 'package:moives_app/providers/movies_provider.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moives_app/providers/auth_provider.dart';

import 'package:moives_app/models/videos.dart';
import 'package:provider/provider.dart';

class MovieDetail extends StatefulWidget {
  static const routeName = '/movie_detail';

  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  var isLoading = false;
  var isInit = true;

  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void didChangeDependencies() {
    final movieId = ModalRoute.of(context)!.settings.arguments as String;
    final loadedMovie = Provider.of<MoviesProviders>(context,listen: false).findById(movieId);

    if (isInit) {
      setState(() {
        isLoading = true;
      });
      Provider.of<MoviesProviders>(context)
          .fetchVideos(loadedMovie.id)
          .then((_) => setState(() {
                isLoading = false;
              }));
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final movieId = ModalRoute.of(context)!.settings.arguments as String;
    final loadedMovie = Provider.of<MoviesProviders>(context,listen: false).findById(movieId);
    final authData = Provider.of<Auth>(context);

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
                    print(movieId);
                    print(loadedMovie.isFavorite);
                    loadedMovie.toggleFavoriteStatus(authData.userId,authData.token);
                    print(loadedMovie.isFavorite);
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
              background: Hero(
                tag: loadedMovie.id,
                child: Image.network(
                    'https://image.tmdb.org/t/p/w500' + loadedMovie.image,
                    fit: BoxFit.cover, errorBuilder: (BuildContext context,
                        Object exception, StackTrace? stackTrace) {
                  return Text('can\'t load image');
                }),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Center(
                    child: Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Text(
                          loadedMovie.title,
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Anton'),
                        ))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text(
                        'Release on:',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                      alignment: Alignment.bottomLeft,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text(
                        loadedMovie.releaseDate.toString(),
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                      alignment: Alignment.topLeft,
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 30),
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                          icon: Icon(
                            Icons.star_purple500_outlined,
                            color: Colors.amber,
                          ),
                          onPressed: () {},
                        )),
                    Container(
                      margin: EdgeInsets.only(left: 2),
                      child: Text(
                        'Average Rating -',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Text(loadedMovie.rate.toString(),
                          style: TextStyle(fontSize: 10)),
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
                      fontFamily: 'Anton',
                    ),
                    softWrap: true,
                  ),
                ),
                SizedBox(height: 10),
                Selector<MoviesProviders, List<Videos>>(
                    selector: (_, model) => model.videoItems,
                    builder: (context, videos, _) {
                      return Column(
                          children: videos.map((video) {
                        var url =
                            "https://www.youtube.com/watch?v=" + video.key;
                        return Column(
                          children: [
                            SizedBox(height: 20),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              width: double.infinity,
                              child: Text(
                                video.key != null ? 'Watch at :' : '',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                                softWrap: true,
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              width: double.infinity,
                              child: InkWell(
                                onTap: () async {
                                  // if (await canLaunch(url))
                                  try {
                                    await launch(url);
                                  } catch (err) {
                                    throw 'Could not launch $url';
                                  }
                                },
                                child: Text(
                                  url,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 16,
                                    color: Colors.red,
                                    fontFamily: 'Anton',
                                  ),
                                  softWrap: true,
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList());
                    }),
                SizedBox(
                  height: 800,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
