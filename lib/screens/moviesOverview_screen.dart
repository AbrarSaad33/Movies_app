import 'package:flutter/material.dart';
import 'package:moives_app/providers/movie_provider.dart';
import 'package:moives_app/providers/movies_provider.dart';
import 'package:moives_app/screens/favoriteMovie_screen.dart';
import 'package:moives_app/widgets/app_drawer.dart';
import '../widgets/movie_grid.dart';
import 'package:provider/provider.dart';

class MoviesOverviewScreen extends StatefulWidget {
  static const routeName = '/movie_overview';
  @override
  _MoviesOverviewScreenState createState() => _MoviesOverviewScreenState();
}

class _MoviesOverviewScreenState extends State<MoviesOverviewScreen> {
  var _showFavoritesOnly = false;
  var isInit = true;
  MOVIE_TYPE selectes = MOVIE_TYPE.ALL;

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
      getData(MOVIE_TYPE.ALL);
      //   if (selected == 0) {
      //     Provider.of<MovieProviders>(context)
      //         .fetchAllMovies()
      //         .then((_) => setState(() {
      //               _isLoading = false;
      //             }));
      //   } else if (selected == 1) {
      //     Provider.of<MovieProviders>(context)
      //         .fetchTopRatrdMovies()
      //         // .then((_) => setState(() {
      //               _isLoading = false;
      //             }));
      //   }
    }
    isInit = false;
    super.didChangeDependencies();
  }

  getData(MOVIE_TYPE selection) {
    Provider.of<MoviesProviders>(context, listen: false)
        .fetchMovies(selection)
        .then((_) => setState(() {
              _isLoading = false;
            }));
  }

  @override
  void dispose() {
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies"),
        actions: [
          PopupMenuButton<MOVIE_TYPE>(
              onSelected: (selected) {
                getData(selected);
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) => [
                    PopupMenuItem(
                      child: Text('All Movies'),
                      value: MOVIE_TYPE.ALL,
                    ),
                    PopupMenuItem(
                      child: Text('Top-Rated'),
                      value: MOVIE_TYPE.TOP_RATED,
                    ),
                    PopupMenuItem(
                      child: Text('UpComing'),
                      value: MOVIE_TYPE.UPCOMING,
                    )
                  ]),
          IconButton(
            color: Theme.of(context).accentColor,
            onPressed: () {
              Navigator.of(context).pushNamed(FavoriteMovies.routeName);
            },
            icon: Icon(Icons.favorite),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : MovieGrid(_showFavoritesOnly),
    );
  }
}
