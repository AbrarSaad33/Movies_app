import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:moives_app/providers/movie.dart';
import 'package:http/http.dart' as http;

class MovieProviders with ChangeNotifier {
  List<Movie> _items = [
    // Movie(
    //     id: 'p1',
    //     title: 'Sabe Alboromba',
    //     description:
    //         'Sabe Alboromba. Genre: Comedy. Director: Mahmoud Karim. Cast: Ramez Galal Bayyumy Fouad Mohammed Tharwat Mohamed Abd Al-Rahman Jamila awad Badria Tolb.',
    //     image:
    //         'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSrFYu5wX24asGfjujNCM4P1fT0Y2dQ--uS87c_FbTXyPAeq5be'),
    // Movie(
    //     id: 'p2',
    //     title: 'Blood Red Sky',
    //     description:
    //         'Blood Red Sky ... When a group of terrorists hijacks an overnight transatlantic flight, a mysteriously ill woman must unleash a monstrous secret to protect',
    //     image:
    //         'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/c7268c79-9436-4230-b75e-2814495b25f4/deml23v-c32cd7c9-d6f2-4bbb-b0ba-cc38fa4b675d.png/v1/fill/w_512,h_512,strp/blood_red_sky_v2_by_nandha602_deml23v-fullview.png?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9NTEyIiwicGF0aCI6IlwvZlwvYzcyNjhjNzktOTQzNi00MjMwLWI3NWUtMjgxNDQ5NWIyNWY0XC9kZW1sMjN2LWMzMmNkN2M5LWQ2ZjItNGJiYi1iMGJhLWNjMzhmYTRiNjc1ZC5wbmciLCJ3aWR0aCI6Ijw9NTEyIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmltYWdlLm9wZXJhdGlvbnMiXX0.rXViacdX6kuwnCdnXbZtQXBn9VIa0kb2Qf9Cuhb8Dbs'),
    // Movie(
    //     id: 'p3',
    //     title: 'The Conjuring',
    //     description:
    //         'rue horror returns. Based on the case files of Ed and Lorraine Warren. #TheConjuring: The Devil Made Me Do It,',
    //     image:
    //         'https://media.elcinema.com/uploads/_315x420_bca5be9b1f735c8a4c2e64b7c80a191a0cb167844860dfc68cbe21ab6ca4fc19.jpg')
  ];

  List<Movie> get items {
    return [..._items];
  }

  List<Movie> get favoriteItems {
    return _items.where((movItem) => movItem.isFavorite).toList();
  }

  void addMovie() {}
  Movie findById(String id) {
    return _items.firstWhere((movie) => movie.id == id);
  }

  Future<void> fetchAllMovies() async {
    final url = Uri.parse(
        "https://api.themoviedb.org/3/movie/popular?api_key=5b12e705c1ab3a4385c6d4bcd63ad3a7");
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


 Future<void> fetchTopRatrdMovies() async {
    final url = Uri.parse(
        "https://api.themoviedb.org/3/movie/top_rated?api_key=5b12e705c1ab3a4385c6d4bcd63ad3a7");
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        Iterable list = result["results"];
        final loadedMovies =list.map((movie) => Movie.fromJson(movie)).toList();
        _items = loadedMovies;
        notifyListeners();
      }
    } catch (error) {
      throw Exception("Failed to load movies!");
    }
  }

 Future<void> fetchUpcomingMovies() async {
    final url = Uri.parse(
        "https://api.themoviedb.org/3/movie/upcoming?api_key=5b12e705c1ab3a4385c6d4bcd63ad3a7");
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        Iterable list = result["results"];
        final loadedMovies =list.map((movie) => Movie.fromJson(movie)).toList();
        _items = loadedMovies;
        notifyListeners();
      }
    } catch (error) {
      throw Exception("Failed to load movies!");
    }
  }

  
}




