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
      movies: (json['Movies'] as List)
          .map((movie) => SeasonMovie.fromJson(movie))
          .toList(),
      season: json['Season'] as int,
    );
  }
}
