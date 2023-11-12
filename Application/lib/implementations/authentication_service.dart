import 'dart:convert';
import 'package:domain/models/authenticated_server.dart';
import 'package:infrastructure/interfaces/iauthentication_service.dart';
import 'package:infrastructure/interfaces/ihttp_provider_service.dart';
import 'package:infrastructure/interfaces/ilocal_storage.dart';
import 'package:infrastructure/interfaces/isignature_service.dart';
import 'package:get_it/get_it.dart';
import 'package:domain/models/http_request.dart';

class AuthenticationService implements IAuthenticationService {
  GetIt getIt = GetIt.I;
  late IlocalStorage _storage;
  late ISignatureService _signatureService;
  late IHttpProviderService _httpProviderService;

  AuthenticationService() {
    _storage = getIt.get<IlocalStorage>();
    _signatureService = getIt.get<ISignatureService>();
    _httpProviderService = getIt.get<IHttpProviderService>();
  }

  @override
  Future<bool> authenticate(AuthenticatedServer server) {
    throw UnimplementedError();
  }

  @override
  Future<List<AuthenticatedServer>> getAuthenticatedServers() async {
    var servers = await _storage.get("Servers") as String;
    Map serverMap = jsonDecode(servers);
    List<AuthenticatedServer> result = [];
    serverMap.forEach((key, value) {
      var current = AuthenticatedServer.fromJson(value);
      result.add(current);
    });

    return result;
  }

  @override
  Future<bool> isAuthenticated() async {
    var servers = await _storage.get("Servers") as String;
    Map serverMap = jsonDecode(servers);
    var isAuthenticated = false;
    serverMap.forEach((key, value) async {
      var current = AuthenticatedServer.fromJson(value);
      var result = await _httpProviderService.getRequest(
        HttpRequest(
          "${current.url}/system/status",
          {},
          {},
        ),
      );

      if (result != null && result.statusCode == 200) {
        isAuthenticated = true;
      }
    });

    return isAuthenticated;
  }

  @override
  Future<bool> logOut(AuthenticatedServer server) async {
    var response = await _httpProviderService.postRequest(
      HttpRequest(
        "${server.url}/authenticate/logout",
        {"Authorize": "Bearer: ${server.bearer}"},
        {},
      ),
    );

    if (response != null && response.statusCode == 200) return true;

    return false;
  }
}
