class HttpRequest {
  final String url;
  final Map<String, String> headers;
  final dynamic params;

  HttpRequest(this.url, this.headers, this.params);
}
