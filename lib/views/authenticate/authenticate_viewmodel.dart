import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infrastructure/interfaces/iauthentication_service.dart';
import 'package:infrastructure/interfaces/ihttp_provider_service.dart';
import 'package:presentation/page_view_model.dart';
import 'package:domain/models/authenticated_server.dart';

class AuthenticateViewModel extends PageViewModel {
  int _row = -1;
  int get row => _row;

  FocusNode _node = FocusNode();
  get node => _node;

  ScrollController _scrollController = ScrollController();
  ScrollController get controller => _scrollController;

  List<AuthenticatedServer> _servers = [];
  List<AuthenticatedServer> get servers => _servers;
  late IAuthenticationService _authenticationService;

  AuthenticateViewModel(super.context);

  ready() async {
    _authenticationService = getIt<IAuthenticationService>();
    _servers = await _authenticationService.getAuthenticatedServers();
    await _authenticationService.authenticate(
      AuthenticatedServer(
        url: "http://192.168.1.105:5000",
        lastResponse: DateTime.now(),
        isOnline: true,
      ),
    );

    notifyListeners();
  }

  void onKeyPressed(RawKeyEvent value) {
    if (value is RawKeyDownEvent) return;

    if (value.logicalKey.keyLabel == "Arrow Up" && _row - 1 >= -1) {
      _row--;
    } else if (_row + 1 < _servers.length &&
        value.logicalKey.keyLabel == "Arrow Down") {
      _row++;
    }

    _node = FocusNode();
    _node.requestFocus();
    int selectedIndex = _row;
    double itemHeight = ThemeStyles.height! / 3.5; // Height of each item

    double viewportHeight = MediaQuery.of(pageContext).size.height;
    double scrollPosition =
        (selectedIndex * itemHeight - (viewportHeight / 3)) + 80;
    scrollPosition = scrollPosition.clamp(
      0.0,
      (itemHeight * (_servers.length - 1)),
    );

    _scrollController.animateTo(
      scrollPosition, // Vertical position
      duration: Duration(milliseconds: 600), // Animation duration
      curve: Curves.easeInOut, // Animation curve
    );
    notifyListeners();
  }
}
