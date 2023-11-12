import 'package:domain/models/authenticated_server.dart';

abstract class IAuthenticationService {
  Future<bool> isAuthenticated();
  Future<bool> authenticate(AuthenticatedServer server);
  Future<bool> logOut(AuthenticatedServer server);
  Future<List<AuthenticatedServer>> getAuthenticatedServers();
}
