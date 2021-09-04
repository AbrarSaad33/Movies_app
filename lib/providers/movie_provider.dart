import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Movie with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final String image;
  final double rate;
  final String releaseDate;
  bool isFavorite;

  Movie(
      {required this.id,
      required this.title,
      required this.description,
      required this.image,
      required this.rate,
      required this.releaseDate,
      this.isFavorite =false});
  // factory Movie.fromJson(Map<String, dynamic> json) {
  //   return Movie(
  //     image: json["poster_path"] as String,
  //     description: json["overview"] as String,
  //     title: json["title"] as String,
  //     id: json["id"].toString(),
  //     rate: json["vote_average"].toDouble(),
  //     releaseDate: json["release_date"],
  //   );
  // }

  void _setFavValue(bool newValue,bool isFavorite) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(String userId,String token) async {
    final oldStatus = isFavorite;

    isFavorite = !isFavorite;
    notifyListeners();
    final url = Uri.parse(
        'https://movieapp-14a99-default-rtdb.firebaseio.com/userFavorites/$userId/$id.json?auth=$token');
    try {
      final response = await http.put(
        url,
        body: json.encode(
          isFavorite,
        ),
      );
      if (response.statusCode >= 400) {
        _setFavValue(oldStatus,isFavorite);
      }
    } catch (error) {
      _setFavValue(oldStatus,isFavorite);
    }
  }

   
  
}
