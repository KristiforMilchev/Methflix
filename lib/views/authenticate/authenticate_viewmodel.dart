import 'package:flutter/material.dart';
import 'package:presentation/page_view_model.dart';
import 'package:domain/models/authenticated_server.dart';

class AuthenticateViewModel extends PageViewModel {
  List<AuthenticatedServer> _servers = [
    AuthenticatedServer(
      url: "192.168.0.106",
      lastResponse: DateTime.now(),
      isOnline: true,
    ),
    AuthenticatedServer(
      url: "192.168.0.106",
      lastResponse: DateTime.now(),
      isOnline: false,
    )
  ];
  List<AuthenticatedServer> get servers => _servers;

  AuthenticateViewModel(super.context);
}
