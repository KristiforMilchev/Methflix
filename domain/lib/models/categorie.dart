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
}
