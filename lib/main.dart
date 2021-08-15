

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:moives_app/providers/movie_provider.dart';
import 'package:moives_app/providers/auth_provider.dart';
import 'package:moives_app/screens/Auth_screen.dart';
import 'package:moives_app/screens/favorite_movie.dart';
import 'package:moives_app/screens/start.dart';
import 'package:moives_app/screens/top_rated.dart';
import 'package:moives_app/screens/upcominfg_movie_screen.dart';
import './screens/movie_detail.dart';
import './screens/movies_overview.dart';
import 'package:provider/provider.dart';

void main() {
HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  bool load = false;


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
     
        ChangeNotifierProvider.value(
          value: MovieProviders(),
        ),
        ChangeNotifierProvider.value(
          value: Auth(),
        )
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'MyMovie ',
          theme: ThemeData(
              primarySwatch: Colors.amber,
              accentColor: Colors.black,
              fontFamily: 'Lato'),
          home:Start(),
          // MoviesOverviewScreen(),
          // auth.isAuth?MoviesOverviewScreen()
          //   :FutureBuilder(future: auth.tryAutoLogin(),builder: (ctx,authResultSnapShot)=>authResultSnapShot.connectionState==ConnectionState.waiting?Text('Loading...'): AuthScreen()) ,
          //
          routes: {
            Start.routeName: (ctx) => Start(),
            AuthScreen.routeName: (ctx) => AuthScreen(),
            MovieDetail.routeName: (ctx) => MovieDetail(),
            MoviesOverviewScreen.routeName: (ctx) => MoviesOverviewScreen(),
            FavoriteMovies.routeName: (ctx) => FavoriteMovies(),
            TopRatedMovieScreen.routeName: (ctx) => TopRatedMovieScreen(),
            UpComingMovieScreen.routeName: (ctx) => UpComingMovieScreen()
          },
        ),
      ),
    );
  }
}
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext ?context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) =>true);
  }
}
