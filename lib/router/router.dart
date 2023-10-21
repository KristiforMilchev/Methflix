import 'package:domain/models/enums.dart';
import 'package:domain/models/transition_data.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:infrastructure/interfaces/ipage_router_service.dart';
import 'package:presentation/views/dashboard/dashboard_view.dart';
import 'package:presentation/views/video_stream/video_stream_view.dart';

class ApplicationRouter {
  //Animations Handles

  static SlideTransition slideTransionHandle(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
    bool direction,
  ) {
    late final Animation<Offset> offsetAnimation;

    if (direction) {
      offsetAnimation = Tween<Offset>(
        begin: const Offset(1.5, 0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOut,
      ));
    } else {
      offsetAnimation = Tween<Offset>(
        begin: const Offset(-1.5, 0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOut,
      ));
    }

    return SlideTransition(
      position: offsetAnimation,
      child: child,
    );
  }

  static FadeTransition fadeTransision(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
    bool direction,
  ) {
    late final Animation<double> fadeAnimation = CurvedAnimation(
      parent: animation,
      curve: direction ? Curves.easeInOut : Curves.easeOut,
    );

    return FadeTransition(
      opacity: fadeAnimation,
      child: child,
    );
  }

  static final List<(String, dynamic, int, Duration)> _routes = [
    ("dashboard-view", DashboardView(), 1, Duration(milliseconds: 500))
  ];

  static const Duration animationDuration = Duration(milliseconds: 500);
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return DashboardView();
        },
        routes: <RouteBase>[
          ..._routes.map(
            (e) => GoRoute(
              path: e.$1,
              pageBuilder: (context, state) {
                return CustomTransitionPage(
                  maintainState: true,
                  key: state.pageKey,
                  transitionDuration: e.$4,
                  child: WillPopScope(
                    onWillPop: () async {
                      GetIt getIt = GetIt.I;

                      IPageRouterService _routerService =
                          getIt.get<IPageRouterService>();
                      _routerService.backToPrevious(context);
                      return false;
                    },
                    child: e.$2,
                  ),
                  transitionsBuilder: (
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ) =>
                      tranisitionController(
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                    state,
                  ),
                );
              },
            ),
          )
        ],
      ),
    ],
  );

  static tranisitionController(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      GoRouterState state) {
    var caller = state.extra as TransitionData;
    print(state.path);
    if (caller.next == PageTransition.easeInAndOut) {
      return fadeTransision(
          context, animation, secondaryAnimation, child, true);
    }

    if (caller.next == PageTransition.slideBack) {
      return slideTransionHandle(
        context,
        animation,
        secondaryAnimation,
        child,
        false,
      );
    }

    if (caller.next == PageTransition.slideForward) {
      return slideTransionHandle(
        context,
        animation,
        secondaryAnimation,
        child,
        true,
      );
    }

    return child;
  }
}

class CustomFadeAnimation extends CurvedAnimation {
  final double min;
  final double max;

  CustomFadeAnimation({
    required super.parent,
    required super.curve,
    super.reverseCurve,
    required this.min,
    required this.max,
  });

  @override
  double get value {
    double valueFromParent = super.value;
    double range = max - min;

    return min + valueFromParent * range;
  }
}
