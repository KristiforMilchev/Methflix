import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:infrastructure/interfaces/iobserver.dart';
import 'package:infrastructure/interfaces/ipage_router_service.dart';
import 'package:localization/localization.dart';
import 'package:stacked/stacked.dart';

class PageViewModel extends BaseViewModel {
  GetIt getIt = GetIt.instance;
  late BuildContext pageContext;
  late IPageRouterService router = getIt.get<IPageRouterService>();
  late IObserver observer = getIt.get<IObserver>();

  PageViewModel(BuildContext context) {
    FocusScope.of(context).unfocus();
    pageContext = context;
    // You can now use the context inside the ViewModel if needed
    FocusManager.instance.primaryFocus?.unfocus();
  }

  onLanaugeChanged(String locale) {
    // switch (locale) {
    //   case "DE":
    //     sessionManager.activeLangauge = 0;
    //     break;
    //   case "EN":
    //     sessionManager.activeLangauge = 1;
    //     break;
    //   default:
    //     sessionManager.activeLangauge = 0;
    //     break;
    // }
    locale = "en_$locale";
    LocalJsonLocalization.delegate.load(Locale(locale));
    notifyListeners();
  }
}
