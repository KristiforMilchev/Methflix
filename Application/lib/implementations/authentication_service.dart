import 'dart:convert';
import 'package:domain/models/authenticated_server.dart';
import 'package:infrastructure/interfaces/iauthentication_service.dart';
import 'package:infrastructure/interfaces/ihttp_provider_service.dart';
import 'package:infrastructure/interfaces/ilocal_storage.dart';
import 'package:infrastructure/interfaces/isignature_service.dart';
import 'package:domain/models/http_request.dart';

class AuthenticationService implements IAuthenticationService {
  IlocalStorage storage;
  ISignatureService signatureService;
  IHttpProviderService httpProviderService;

  AuthenticationService(
    this.signatureService,
    this.httpProviderService,
    this.storage,
  );
  @override
  Future<bool> authenticate(AuthenticatedServer server) async {
    var servers = await getAuthenticatedServers();
    if (servers.any((element) => element.url == server.url)) return false;

    var start = throw UnimplementedError();
  }

  @override
  Future<List<AuthenticatedServer>> getAuthenticatedServers() async {
    var servers = await storage.get("Servers") as String;
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
    var servers = await storage.get("Servers") as String;
    Map serverMap = jsonDecode(servers);
    var isAuthenticated = false;
    serverMap.forEach((key, value) async {
      var current = AuthenticatedServer.fromJson(value);
      var result = await httpProviderService.getRequest(
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
    var response = await httpProviderService.postRequest(
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
