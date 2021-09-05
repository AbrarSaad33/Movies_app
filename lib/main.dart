import 'package:flutter/material.dart';
import 'package:moives_app/providers/auth_provider.dart';
import 'package:moives_app/providers/movies_provider.dart';
import 'package:moives_app/screens/auth_screen.dart';
import 'package:moives_app/screens/favoriteMovie_screen.dart';
import 'package:moives_app/screens/splash_screen.dart';
import 'screens/movieDetails_screen.dart';
import 'screens/moviesOverview_screen.dart';
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
          home: Start(),
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
         
          },
        ),
      ),
    );
  }
}

