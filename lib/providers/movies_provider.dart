import 'package:flutter/cupertino.dart';
import 'package:moives_app/models/network_manger.dart';
import 'package:moives_app/providers/movie_provider.dart';
import 'package:moives_app/models/videos.dart';

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
    final result = await NetworkManager().get("http://api.themoviedb.org/3/movie/$moviesUrl?api_key=5b12e705c1ab3a4385c6d4bcd63ad3a7",);
    final favoriteData = await NetworkManager().get(
        'https://movieapp-14a99-default-rtdb.firebaseio.com/userFavorites/$_userId.json?auth=$_authToken');

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
   final result = await NetworkManager().get("http://api.themoviedb.org/3/movie/$movieId/videos?api_key=5b12e705c1ab3a4385c6d4bcd63ad3a7");
    List list = result["results"];
    final List<Videos> loadedVideos = [];
    list.forEach((videoData) {
      loadedVideos.add(Videos(key: videoData['key'] as String));
    });
    videoItems = loadedVideos;

    notifyListeners();
  }

  
}
