import 'package:flutter/cupertino.dart';

class Movie with ChangeNotifier{
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

      void toggleFavoriteStatus(){
        isFavorite=!isFavorite;
        notifyListeners();
      }
}
