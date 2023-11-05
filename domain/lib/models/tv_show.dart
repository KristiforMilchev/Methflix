class TvShow {
  int id;
  String name;
  String thumbnail;
  int movieCount;
  int seasons;
  String? description;

  TvShow({
    required this.id,
    required this.name,
    required this.thumbnail,
    this.movieCount = 0,
    this.seasons = 1,
    this.description,
  });

  factory TvShow.fromJson(Map<String, dynamic> json) {
    return TvShow(
      id: json['id'],
      name: json['name'] as String,
      thumbnail: json['thumbnail'] as String,
      movieCount: json['movieCount'] as int,
      seasons: json['seasons'] as int,
    );
  }
}
