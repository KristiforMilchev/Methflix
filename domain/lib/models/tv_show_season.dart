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
      name: json['Name'] as String,
      seasons: (json['Seasons'] as List)
          .map((season) => SeasonData.fromJson(season))
          .toList(),
    );
  }
}
