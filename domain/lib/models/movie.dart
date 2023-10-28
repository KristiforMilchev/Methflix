import 'package:domain/formatters/time_formatter.dart';

class Movie {
  int id;
  String thumbnail;
  String name;
  Duration length;

  Movie({
    required this.id,
    required this.thumbnail,
    required this.name,
    required this.length,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      thumbnail: json['thumbnail'],
      name: json["name"],
      length: TimeFormatters.timespanToDuration(json['lenght']),
    );
  }
}
