class AuthenticatedServer {
  String url;
  DateTime lastResponse;
  bool isOnline;
  String name;
  String bearer;
  DateTime? expiring;

  AuthenticatedServer({
    required this.url,
    required this.lastResponse,
    required this.isOnline,
    this.name = "",
    this.bearer = "",
    this.expiring,
  });

  factory AuthenticatedServer.fromJson(Map<String, dynamic> json) {
    return AuthenticatedServer(
        url: json['url'],
        lastResponse: DateTime.parse(json['lastResponse']),
        isOnline: json['isOnline'],
        name: json['name'] ?? "",
        bearer: json["bearer"] ?? "",
        expiring: json["expiring"]);
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'lastResponse': lastResponse.toIso8601String(),
      'isOnline': isOnline,
      'name': name,
      'bearer': bearer,
      'expiring': expiring,
    };
  }
}
