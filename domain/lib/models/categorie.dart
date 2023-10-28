import 'package:domain/models/movie.dart';

class Category {
  int id;
  String name;
  List<Movie> movies;

  Category({
    required this.id,
    required this.name,
    required this.movies,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    List<dynamic> movieList = json['movies'];
    List<Movie> movies = [];
    if (movieList.isNotEmpty) {
      movies = movieList.map((movieJson) {
        return Movie.fromJson(movieJson);
      }).toList();
    }

    return Category(
      id: json['id'],
      name: json['name'],
      movies: movies,
    );
  }
}
