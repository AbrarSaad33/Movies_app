import 'package:flutter/cupertino.dart';

class Movie with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final String image;
  bool isFavorite;

  Movie(
      {required this.id,
      required this.title,
      required this.description,
      required this.image,
      this.isFavorite = false});
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        image: json["poster_path"] as String,
        description: json["overview"] as String,
        title: json["title"] as String,
        id: json["id"] .toString());
  }

    void toggleFavoriteStatus() {
      isFavorite = !isFavorite;
      notifyListeners();
    }
  }


