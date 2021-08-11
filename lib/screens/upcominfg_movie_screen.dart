import 'package:flutter/material.dart';
import 'package:moives_app/providers/movie.dart';
import 'package:moives_app/providers/movie_provider.dart';
import 'package:moives_app/screens/favorite_movie.dart';
import 'package:moives_app/screens/movies_overview.dart';
import 'package:moives_app/screens/top_rated.dart';
import 'package:moives_app/widgets/app_drawer.dart';
import '../widgets/movie_grid.dart';
import 'package:provider/provider.dart';

class UpComingMovieScreen extends StatefulWidget {
  static const routeName = '/Up_Coming';
  @override
  UpComingScreenState createState() => UpComingScreenState();
}

class UpComingScreenState extends State<UpComingMovieScreen> {
  var _showFavoritesOnly = false;
  var isInit = true;
  final List<Movie> movies = [];

  var _isLoading = false;
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  // @override
  // void initState() {
  //   Future.delayed(Duration.zero).then((_){
  //   Provider.of<MovieProviders>(context,listen: false).fetchAllMovies();
  //   });
  //   super.initState();

  // }

  @override
  void didChangeDependencies() {
    if (isInit) {
      setState(() {
        _isLoading = true;
      });

//  void _populateAllMovies() async {
//     final movies = await _fetchAllMovies();
//     setState(() {
//      _items = movies;
//     });
//   }

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
        title: const Text('UPComing'),
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
                  Navigator.of(context).pushNamed(UpComingMovieScreen.routeName);
                }
                else if(selected==1){
                   Navigator.of(context)
                      .pushNamed(TopRatedMovieScreen.routeName);
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
                child: Text('UPComing'),
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
