import 'package:flutter/cupertino.dart';

class Movie with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final String image;
  final double rate;
  bool isFavorite;

  Movie(
      {required this.id,
      required this.title,
      required this.description,
      required this.image,
      required this.rate,
      this.isFavorite = false});
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        image: json["poster_path"] as String,
        description: json["overview"] as String,
        title: json["title"] as String,
        id: json["id"].toString(),
        rate:  json["vote_average"].toDouble()
        );
        
  }

  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
