class AuthenticatedServer {
  String url;
  DateTime lastResponse;
  bool isOnline;
  String name;

  AuthenticatedServer({
    required this.url,
    required this.lastResponse,
    required this.isOnline,
    this.name = "",
  });
}
