class AuthenticatedServer {
  String url;
  DateTime lastResponse;
  bool isOnline;
  String name;
  String bearer;
  AuthenticatedServer({
    required this.url,
    required this.lastResponse,
    required this.isOnline,
    this.name = "",
    this.bearer = "",
  });

  factory AuthenticatedServer.fromJson(Map<String, dynamic> json) {
    return AuthenticatedServer(
      url: json['url'],
      lastResponse: DateTime.parse(json['lastResponse']),
      isOnline: json['isOnline'],
      name: json['name'] ?? "",
      bearer: json["bearer"] ?? "",
    );
  }
}
