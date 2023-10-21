import 'package:domain/models/core_router.dart';
import 'package:domain/models/enums.dart';
import 'package:domain/models/page_route.dart';
import 'package:domain/models/transition_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:infrastructure/interfaces/iobserver.dart';
import 'package:infrastructure/interfaces/ipage_router_service.dart';

class PageRouterService implements IPageRouterService {
  List<PageRoutePoint> routes = [];

  @override
  late CoreRouter router;

  @override
  late int currentIndex = 0;

  @override
  late Object? callbackResult;

  @override
  late String lastPage;

  @override
  late String onSubmit;

  @override
  late String dashboard;

  @override
  late IObserver observer;
  late BuildContext _currentContext;
  PageRouterService(IObserver current) {
    observer = current;
  }

  @override
  backToPrevious(BuildContext context, {bool reverse = false}) {
    dismissBar();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    var page = routes.elementAt(routes.length - 2);
    routes.removeLast();
    observer.disposeAll();
    context.go(
      page.route,
      extra: TransitionData(
        next: reverse ? PageTransition.slideForward : PageTransition.slideBack,
      ),
    );
  }

  @override
  backToPreviousFirst(BuildContext context, String route) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    observer.disposeAll();

    dismissBar();
    List<PageRoutePoint> newRoutes = [];

    for (final element in routes) {
      if (element.route == route) {
        break;
      }
      newRoutes.add(element);
    }

    var page = newRoutes.last;
    routes = newRoutes;
    context.go(
      page.route,
      extra: TransitionData(
        next: PageTransition.slideBack,
      ),
    );
  }

  @override
  bool changePage(String name, BuildContext context, TransitionData data,
      {Object? bindingData}) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    observer.disposeAll();

    dismissBar();
    routes.add(PageRoutePoint(route: name, data: bindingData));

    context.go(name, extra: data);
    return true;
  }

  @override
  void registerRouter(CoreRouter currentRouter) {
    router = currentRouter;
  }

  @override
  void setPageIndex(int index) {
    currentIndex = index;
  }

  @override
  void setCallbackResult(Object current) {
    callbackResult = current;
  }

  @override
  bool clearNavigationData() {
    routes.clear();
    return true;
  }

  @override
  Object? getPageBindingData() {
    return routes.elementAt(routes.length - 1).data;
  }

  @override
  openBar(Widget content, BuildContext context) async {
    _currentContext = context;
    showModalBottomSheet(
        useSafeArea: true,
        backgroundColor: Color.fromRGBO(0, 0, 0, 0),
        useRootNavigator: true,
        barrierColor: Color.fromRGBO(0, 0, 0, 0),
        elevation: 22,
        isScrollControlled: true,
        context: context,
        builder: (context) => Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: Colors.black,
              ),
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              margin: const EdgeInsets.all(0),
              child: IntrinsicHeight(
                child: Container(
                  padding: const EdgeInsets.all(0),
                  margin: const EdgeInsets.all(0),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(192, 192, 192, 0.3),
                        Color.fromRGBO(192, 192, 192, 0),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Stack(
                    children: [
                      content,
                    ],
                  ),
                ),
              ),
            ));
  }

  @override
  dismissBar() async {
    Navigator.pop(_currentContext);
  }
}
