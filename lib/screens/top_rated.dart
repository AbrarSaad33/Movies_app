// import 'package:flutter/material.dart';
// import 'package:moives_app/providers/movie.dart';
// import 'package:moives_app/providers/movie_provider.dart';
// import 'package:moives_app/widgets/app_drawer.dart';
// import '../widgets/movie_grid.dart';
// import 'package:provider/provider.dart';

// import 'favorite_movie.dart';

// class TopRatedMovieScreen extends StatefulWidget {
//   static const routeName = '/Top_rated';
//   @override
//   TopRatedMovieScreenState createState() => TopRatedMovieScreenState();
// }

// class TopRatedMovieScreenState extends State<TopRatedMovieScreen> {
//   var _showFavoritesOnly = false;
//   var isInit = true;
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
//           .fetchTopRatrdMovies()
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
//         title: const Text('Top Rated Movies'),
//           actions: [
//           IconButton(
//             color: Theme.of(context).accentColor,
//             onPressed: () {
//               Navigator.of(context).pushNamed(FavoriteMovies.routeName);
//               _showFavoritesOnly = true;
//             },
//             icon:const Icon(Icons.favorite),
//           ),
//         ],
//       ),
//     // drawer: AppDrawer(),
//       body:  isLoading
//           ? Center(
//               child: CircularProgressIndicator(),
//             )
//           : MovieGrid(_showFavoritesOnly),
//     );
//   }
// }
