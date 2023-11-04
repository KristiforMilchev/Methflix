import 'package:domain/models/season_movie.dart';

class SeasonData {
  List<SeasonMovie> movies;
  int season;

  SeasonData({
    required this.movies,
    required this.season,
  });

  factory SeasonData.fromJson(Map<String, dynamic> json) {
    return SeasonData(
      movies: (json['movies'] as List)
          .map((movie) => SeasonMovie.fromJson(movie))
          .toList(),
      season: json['season'] as int,
    );
  }
}
