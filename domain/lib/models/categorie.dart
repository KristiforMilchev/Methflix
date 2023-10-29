import 'package:domain/models/movie.dart';
import 'package:domain/models/tv_show.dart';

class Category {
  int id;
  String name;
  List<Movie> movies;
  List<TvShow> shows;

  Category({
    required this.id,
    required this.name,
    required this.movies,
    required this.shows,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    List<dynamic> movieList = json['movies'];
    List<dynamic> showList = json['tvShows'];

    List<Movie> movies = [];
    if (movieList.isNotEmpty) {
      movies = movieList.map((movieJson) {
        return Movie.fromJson(movieJson);
      }).toList();
    }

    List<TvShow> tvShows = [];
    if (showList.isNotEmpty) {
      tvShows = showList.map((e) {
        return TvShow.fromJson(e);
      }).toList();
    }

    return Category(
      id: json['id'],
      name: json['name'],
      movies: movies,
      shows: tvShows,
    );
  }
}
