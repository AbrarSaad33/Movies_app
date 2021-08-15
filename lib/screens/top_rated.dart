import 'package:flutter/material.dart';
import 'package:moives_app/providers/movie.dart';
import 'package:moives_app/providers/movie_provider.dart';
import 'package:moives_app/screens/movies_overview.dart';
import 'package:moives_app/screens/upcominfg_movie_screen.dart';
import 'package:moives_app/widgets/app_drawer.dart';
import '../widgets/movie_grid.dart';
import 'package:provider/provider.dart';

class TopRatedMovieScreen extends StatefulWidget {
  static const routeName = '/Top_rated';
  @override
  TopRatedMovieScreenState createState() => TopRatedMovieScreenState();
}

class TopRatedMovieScreenState extends State<TopRatedMovieScreen> {
  var _showFavoritesOnly = false;
  var isInit = true;
  final List<Movie> movies = [];

  var _isLoading = false;
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<MovieProviders>(context)
          .fetchTopRatrdMovies()
          .then((_) => setState(() {
                _isLoading = false;
              }));
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Movies'),
        actions: [
          // IconButton(
          //   color: Theme.of(context).accentColor,
          //   onPressed: () {
          //     Navigator.of(context).pushNamed(FavoriteMovies.routeName);
          //     setState(() {
          //       _showFavoritesOnly = true;
          //     });
          //   },
          //   icon: Icon(Icons.favorite),
          // ),
          PopupMenuButton(
            onSelected: (selected) {
              setState(() {
                if (selected == 0) {
                  // _showFavoritesOnly = false;
                  Navigator.of(context)
                      .pushNamed(MoviesOverviewScreen.routeName);
                } else if (selected == 2) {
                  Navigator.of(context)
                      .pushNamed(UpComingMovieScreen.routeName);
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (ctx) => [
              PopupMenuItem(
                child: Text('All'),
                value: 0,
              ),
              PopupMenuItem(
                child: Text('Top Rated'),
                value: 1,
              ),
              PopupMenuItem(
                child: Text('UpComing'),
                value: 2,
              ),
            ],
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: MovieGrid(_showFavoritesOnly),
    );
  }
}
