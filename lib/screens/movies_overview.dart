import 'package:flutter/material.dart';
import 'package:moives_app/providers/movie_provider.dart';
import 'package:moives_app/screens/favorite_movie.dart';
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
          .getMovie()
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
        title: const Text('MyMovie'),
        actions: [
          IconButton(
            color: Theme.of(context).accentColor,
            onPressed: () {  
                Navigator.of(context).pushNamed(FavoriteMovies.routeName);
              setState(() { 
                   
                _showFavoritesOnly = true;
              });
               
            },
            icon: Icon(Icons.favorite),
          ),
          PopupMenuButton(
            onSelected: (selected) {
              setState(() {
                if (selected == 0) {
                  _showFavoritesOnly = false;
                } else {}
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (ctx) => [
              PopupMenuItem(
                child: Text('All'),
                value: 0,
              ),
              PopupMenuItem(
                child: Text('Arabic Movie'),
                value: 1,
              ),
              PopupMenuItem(
                child: Text('English Movie'),
                value: 2,
              ),
              PopupMenuItem(
                child: Text('Carton Movie'),
                value: 3,
              )
            ],
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: MovieGrid(_showFavoritesOnly),
    );
  }
}
