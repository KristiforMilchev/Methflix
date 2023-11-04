import 'package:domain/models/season_data.dart';

class TvShowSeason {
  String name;
  List<SeasonData> seasons;

  TvShowSeason({
    required this.name,
    required this.seasons,
  });

  factory TvShowSeason.fromJson(Map<String, dynamic> json) {
    return TvShowSeason(
      name: json['name'] as String,
      seasons: (json['seasons'] as List)
          .map((season) => SeasonData.fromJson(season))
          .toList(),
    );
  }
}
