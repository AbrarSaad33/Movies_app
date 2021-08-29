import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:moives_app/providers/movie.dart';
import 'package:http/http.dart' as http;
import 'package:moives_app/providers/videos.dart';

class MovieProviders with ChangeNotifier {
  List<Movie> _items = [];
  //final String authToken ;
  //final String userId ;

  //MovieProviders(this.authToken, this.userId, this._items);
  List<Movie> get items {
    return [..._items];
  }

  // String? _authToken;
  // set authToken(String value) {
  //   _authToken = value;
  // }

  // String? MovieId;
  // set userId(String MovieIdValue) {
  //   MovieId = MovieIdValue;
  // }

  List<Movie> get favoriteItems {
    return _items.where((movItem) => movItem.isFavorite).toList();
  }

  void addMovie() {}
  Movie findById(String id) {
    return _items.firstWhere(
      (movie) => movie.id == id,
      //orElse: () => 'No matching color found' as Movie
    );
  }

  Future<void> fetchAllMovies() async {
    final url = Uri.parse(
        "http://api.themoviedb.org/3/movie/popular?api_key=5b12e705c1ab3a4385c6d4bcd63ad3a7");
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        // print(result);
        Iterable list = result["results"];

        final loadedMovies =
            list.map((movie) => Movie.fromJson(movie)).toList();
        _items = loadedMovies;
        notifyListeners();
      }
    } catch (error) {
      throw (error.toString());
    }
  }

  Future<void> fetchTopRatrdMovies() async {
    final url = Uri.parse(
        "http://api.themoviedb.org/3/movie/top_rated?api_key=5b12e705c1ab3a4385c6d4bcd63ad3a7");
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        Iterable list = result["results"];
        final loadedMovies =
            list.map((movie) => Movie.fromJson(movie)).toList();
        _items = loadedMovies;
        notifyListeners();
      }
    } catch (error) {
      throw Exception("Failed to load movies!");
    }
  }

  Future<void> fetchUpcomingMovies() async {
    final url = Uri.parse(
        "http://api.themoviedb.org/3/movie/upcoming?api_key=5b12e705c1ab3a4385c6d4bcd63ad3a7");
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        Iterable list = result["results"];
        final loadedMovies =
            list.map((movie) => Movie.fromJson(movie)).toList();
        _items = loadedMovies;
        notifyListeners();
      }
    } catch (error) {
      throw Exception("Failed to load movies!");
    }
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
}
