import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
      rate: json["vote_average"].toDouble(),
      //  isFavorite:  json['isFavorite']as bool
    );
  }

  void _setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(String token, String userId) async {
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
        _setFavValue(oldStatus);
      }
    } catch (error) {
      _setFavValue(oldStatus);
    }
  }

  // Future<void> fetch(String token, String userId) async {
  //   final url = Uri.parse(
  //       'https://movieapp-14a99-default-rtdb.firebaseio.com/userFavorites/$userId/$id.json?auth=$token');
  //   final response = await http.get(url);
  //   final result = json.decode(response.body);
  //   print(result);
  // }
}
