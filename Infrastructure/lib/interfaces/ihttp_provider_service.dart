import 'package:domain/models/http_request.dart';
import 'package:http/http.dart';

abstract class IHttpProviderService {
  void setToken(String token, dynamic value);

  Future<Response?> getRequest(HttpRequest request,
      {bool isAuthenticated = false});
  Future<Response?> postRequest(HttpRequest request,
      {bool isAuthenticated = false});
  Future<Response?> putReqest(HttpRequest request,
      {bool isAuthenticated = false});
}
