import 'package:flutter/material.dart';
import 'package:moives_app/providers/movie_provider.dart';
import 'package:moives_app/providers/auth_provider.dart';
import 'package:moives_app/screens/Auth_screen.dart';
import 'package:moives_app/screens/favorite_movie.dart';
import 'package:moives_app/screens/top_rated.dart';
import './screens/movie_detail.dart';
import './screens/movies_overview.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [ 
      ChangeNotifierProvider.value(value: MovieProviders(), ),
      ChangeNotifierProvider.value(value: Auth(),)],
    
      child: Consumer<Auth>(
        builder: (ctx,auth,child)=>  MaterialApp(
          title: 'MyMovie ',
          theme: ThemeData(
              primarySwatch: Colors.pink,
              accentColor: Colors.black,
              fontFamily: 'Lato'),
          home:MoviesOverviewScreen(),
          //auth.isAuth?MoviesOverviewScreen()
          //:AuthScreen(),
          routes: {
            MovieDetail.routeName: (ctx) => MovieDetail(),
            MoviesOverviewScreen.routeName:(ctx)=>MoviesOverviewScreen(),
            FavoriteMovies.routeName:(ctx)=>FavoriteMovies(),
            TopRatedMovieScreen.routeName:(ctx)=>TopRatedMovieScreen()
          },
        ),
       
      ),
    );
  }
}
