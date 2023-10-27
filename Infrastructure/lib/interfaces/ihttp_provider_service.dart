// ignore_for_file: avoid_shadowing_type_parameters

import 'package:domain/models/http_request.dart';

abstract class IHttpProviderService {
  void setToken(String token, dynamic value);

  Future<String?> getRequest(HttpRequest request,
      {bool isAuthenticated = false});
  Future<String?> postRequest(HttpRequest request,
      {bool isAuthenticated = false});
  Future<String?> putReqest(HttpRequest request,
      {bool isAuthenticated = false});
}
