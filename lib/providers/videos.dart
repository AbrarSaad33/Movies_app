class Videos {
 // final String movieId;
  final String key;
  Videos({
   // required this.movieId,
     required this.key});

  factory Videos.fetchKeyfromJson(Map<String, dynamic> json) {
    return Videos(
      //movieId: json["id"] as String,
    key: json["key"] as String);
  }

  
}
