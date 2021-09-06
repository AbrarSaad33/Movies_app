import 'package:flutter/material.dart';
import 'package:moives_app/providers/auth_provider.dart';
import 'package:moives_app/providers/movies_provider.dart';
import 'package:moives_app/screens/auth_screen.dart';
import 'package:moives_app/screens/favorite_movie_screen.dart';
import 'package:moives_app/screens/splash_screen.dart';
import 'screens/movie_detail_screen.dart';
import 'screens/movies_overview_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Auth()),
        ChangeNotifierProxyProvider<Auth, MoviesProviders>(
          create: (_) => MoviesProviders(),
          update: (ctx, auth, previousMovies) {
            previousMovies!..authToken = auth.token;
            previousMovies..userId = auth.userId;
            print(previousMovies);
            return previousMovies;
          },
        ),

        // ChangeNotifierProvider(create: (_)=>Videos(key: key),
        // ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, child) => MaterialApp(
          debugShowCheckedModeBanner: true,
          title: 'MyMovie ',
          theme: ThemeData(
              primarySwatch: Colors.amber,
              accentColor: Colors.black,
              fontFamily: 'Lato'),
          home: SplashScreen(),
          routes: {
            SplashScreen.routeName: (ctx) => SplashScreen(),
            AuthScreen.routeName: (ctx) => AuthScreen(),
            MovieDetailScreen.routeName: (ctx) => MovieDetailScreen(),
            MoviesOverviewScreen.routeName: (ctx) => MoviesOverviewScreen(),
            FavoriteMovieScreen.routeName: (ctx) => FavoriteMovieScreen(),
          },
        ),
      ),
    );
  }
}
