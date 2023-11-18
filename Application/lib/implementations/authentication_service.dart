import 'dart:convert';
import 'package:domain/models/authenticated_server.dart';
import 'package:infrastructure/interfaces/iauthentication_service.dart';
import 'package:infrastructure/interfaces/ihttp_provider_service.dart';
import 'package:infrastructure/interfaces/ilocal_storage.dart';
import 'package:infrastructure/interfaces/isignature_service.dart';
import 'package:domain/models/http_request.dart';
import 'package:domain/models/ed25519_key_pair.dart';

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

    var startRequest = await httpProviderService.getRequest(
        HttpRequest("${server.url}/API/V1/Authentication/Init", {}, {}));
    if (startRequest == null || startRequest.statusCode != 200) return false;

    var message = startRequest.body;
    var kp = await signatureService.generateRsaPrivateKey();
    var edKey = Ed25519KeyPair(kp);
    var key = await edKey.keyPair.extractPublicKey();

    var signed = await signatureService.signMessage(kp, message);

    var kpjson = jsonEncode(await edKey.toJson());
    await storage.set("kp-${server.url}", kpjson);

    var procesed = await httpProviderService.postRequest(
      HttpRequest(
        "${server.url}/API/V1/Authentication/Verify",
        {},
        {
          "PublicKey": base64Encode(key.bytes),
          "Signature": base64Encode(signed.bytes)
        },
      ),
    );

    if (procesed == null || procesed.statusCode != 200) return false;

    return true;
  }

  @override
  Future<List<AuthenticatedServer>> getAuthenticatedServers() async {
    var servers = await storage.get("Servers") as String?;
    if (servers == null) return [];
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
    var servers = await storage.get("Servers") as String?;
    if (servers == null) return false;

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
