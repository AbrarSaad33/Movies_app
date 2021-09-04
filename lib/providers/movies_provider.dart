import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:moives_app/providers/movie_provider.dart';
import 'package:http/http.dart' as http;
import 'package:moives_app/providers/videos.dart';

enum MOVIE_TYPE { TOP_RATED, UPCOMING, ALL }

class MoviesProviders with ChangeNotifier {
  List<Movie> _items = [];
  List<Movie> get items {
    return [..._items];
  }

  String? _authToken;
  set authToken(String value) {
    _authToken = value;
  }

  String? _userId;
  set userId(String userIdValue) {
    _userId = userIdValue;
  }

  List<Movie> get favoriteItems {
    return _items.where((movItem) => movItem.isFavorite).toList();
  }

  void addMovie() {}
  Movie findById(String id) {
    return _items.firstWhere(
      (movie) => movie.id == id,
    );
  }

  Future<void> fetchMovies(MOVIE_TYPE type) async {
    switch (type) {
      case MOVIE_TYPE.ALL:
        return await fetchAllMovies();
      case MOVIE_TYPE.TOP_RATED:
        return await fetchTopRatrdMovies();
      case MOVIE_TYPE.UPCOMING:
        return await fetchUpcomingMovies();
      default:
    }
  }

  Future<void> fetch(String moviesUrl) async {
    var url = Uri.parse(
        "http://api.themoviedb.org/3/movie/$moviesUrl?api_key=5b12e705c1ab3a4385c6d4bcd63ad3a7");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final result = json.decode(response.body) as Map<String, dynamic>;
        url = Uri.parse(
            'https://movieapp-14a99-default-rtdb.firebaseio.com/userFavorites/$_userId.json?auth=$_authToken');
        // print(result);
        final favoriteResponse = await http.get(url);
        final favoriteData = json.decode(favoriteResponse.body);
        List loaded = result["results"];
        final List<Movie> loadedMovies = [];
        loaded.forEach((movieData) {
          loadedMovies.add(Movie(
            id: movieData['id'].toString(),
            title: movieData["title"] as String,
            description: movieData["overview"] as String,
            image: movieData["poster_path"] as String,
            rate: movieData["vote_average"].toDouble(),
            releaseDate: movieData["release_date"],
            isFavorite: favoriteData == null
                ? false
                : favoriteData[movieData['id'].toString()] ?? false,
                
          ));
        });
        print(loadedMovies);
        _items = loadedMovies;
        print(_items);
        notifyListeners();
      }
    } catch (error) {
      throw (error.toString());
    }
  }

  Future<void> fetchAllMovies() async {
    await fetch("popular");
  }

  Future<void> fetchTopRatrdMovies() async {
    await fetch("top_rated");
  }

  Future<void> fetchUpcomingMovies() async {
    await fetch("upcoming");
  }

  List<Videos> videoItems = [];
  Future<void> fetchVideos(String movieId) async {
    var url = Uri.parse(
        "http://api.themoviedb.org/3/movie/$movieId/videos?api_key=5b12e705c1ab3a4385c6d4bcd63ad3a7");
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        print(result);

        Iterable list = result["results"];
        final loadedMovies =
            list.map((video) => Videos.fetchKeyfromJson(video)).toList();
        videoItems = loadedMovies;

        notifyListeners();
        print(loadedMovies);
      }
    } catch (error) {
      throw Exception("Failed to load movies!");
    }
  }

  // void _setFavValue(bool newValue, bool isFavorite) {
  //   isFavorite = newValue;
  //   notifyListeners();
  // }

  // Future<void> toggleFavoriteStatus(String id, bool isFavorite) async {
  //   final oldStatus = isFavorite;
  //  // print(oldStatus);
  //   isFavorite = !isFavorite;
  //   notifyListeners();
  //   final url = Uri.parse(
  //       'https://movieapp-14a99-default-rtdb.firebaseio.com/userFavorites/$_userId/$id.json?auth=$_authToken');
  //   try {
  //     final response = await http.put(
  //       url,
  //       body: json.encode(
  //         isFavorite,
  //       ),
  //     );
  //     if (response.statusCode >= 400) {
  //       _setFavValue(oldStatus, isFavorite);
  //     }
  //   } catch (error) {
  //     _setFavValue(oldStatus, isFavorite);
  //   }
  // }
}
