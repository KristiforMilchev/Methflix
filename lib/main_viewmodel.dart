import 'package:domain/exceptions/base_exception.dart';
import 'package:domain/models/core_router.dart';
import 'package:domain/styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:infrastructure/interfaces/iexception_manager.dart';
import "package:infrastructure/interfaces/ipage_router_service.dart";
import 'package:stacked/stacked.dart';

class MainViewModel extends BaseViewModel {
  late BuildContext _context;
  GetIt getIt = GetIt.instance;
  late IPageRouterService routerService;
  late MaterialApp _app;
  late IExceptionManager _exceptionManager;
  late bool? _isConfigured;
  bool? get isConfigured => _isConfigured;
  MaterialApp get app => _app;
  late CoreRouter? _router;
  CoreRouter? get router => _router;

  initialized(CoreRouter router, BuildContext context) async {
    _context = context;
    _router = router;
    _exceptionManager = getIt.get<IExceptionManager>();
    routerService = getIt.get<IPageRouterService>();
    routerService.registerRouter(router);
    var deviceDimensions = MediaQuery.of(context).size;
    ThemeStyles.width = deviceDimensions.width;
    ThemeStyles.height = deviceDimensions.height;

    registerGlobalExceptionHandler();
    notifyListeners();
  }

  void registerGlobalExceptionHandler() async {
    PlatformDispatcher.instance.onError = (error, stack) {
      if (error is BaseException) {
        _exceptionManager.raisePopup(error);
      }
      print(error);
      return true;
    };
  }

  onBackAction() {
    routerService.backToPrevious(_context);
  }
}
