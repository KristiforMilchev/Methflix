class SeasonMovie {
  int id;
  String name;

  SeasonMovie({
    required this.id,
    required this.name,
  });

  factory SeasonMovie.fromJson(Map<String, dynamic> json) {
    return SeasonMovie(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }
}
