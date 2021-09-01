// import 'package:flutter/material.dart';
// import 'package:moives_app/providers/movie.dart';
// import 'package:moives_app/providers/movie_provider.dart';
// import 'package:moives_app/widgets/app_drawer.dart';
// import '../widgets/movie_grid.dart';
// import 'package:provider/provider.dart';

// import 'favorite_movie.dart';

// class UpComingMovieScreen extends StatefulWidget {
//   static const routeName = '/Up_Coming';
//   @override
//   UpComingScreenState createState() => UpComingScreenState();
// }

// class UpComingScreenState extends State<UpComingMovieScreen> {
//   var _showFavoritesOnly = false;
//   var isInit = true;
//   final List<Movie> movies = [];

//   var isLoading = false;
//   void setState(fn) {
//     if (mounted) super.setState(fn);
//   }

//   @override
//   void didChangeDependencies() {
//     if (isInit) {
//       setState(() {
//         isLoading = true;
//       });
//       Provider.of<MovieProviders>(context)
//           .fetchUpcomingMovies()
//           .then((_) => setState(() {
//                 isLoading = false;
//               }));
//     }
//     isInit = false;
//     super.didChangeDependencies();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('UPComing'),
//         actions: [
//           IconButton(
//             color:Theme.of(context).accentColor,
//             onPressed: () {
//               Navigator.of(context).pushNamed(FavoriteMovies.routeName);
//               _showFavoritesOnly = true;
//             },
//             icon: Icon(Icons.favorite),
//           ),
//         ],
//       ),
//      // drawer: AppDrawer(),
//       body: isLoading
//           ? Center(
//               child: CircularProgressIndicator(),
//             )
//           :  MovieGrid(_showFavoritesOnly),
//     );
//   }
// }
