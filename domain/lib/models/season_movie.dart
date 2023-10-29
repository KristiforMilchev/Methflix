class SeasonMovie {
  int id;
  String name;

  SeasonMovie({
    required this.id,
    required this.name,
  });

  factory SeasonMovie.fromJson(Map<String, dynamic> json) {
    return SeasonMovie(
      id: json['Id'] as int,
      name: json['Name'] as String,
    );
  }
}
