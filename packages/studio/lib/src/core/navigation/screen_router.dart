import 'package:flutter/material.dart';
import 'package:studio/src/core/dependencies/dependency.dart';
import 'package:studio/src/core/navigation/screen_not_found_exception.dart';
import 'package:studio/src/core/navigation/screen_route.dart';
import 'package:studio/src/core/navigation/screen_routes.dart';

final _expando = Expando<_ScreenRouterState>();

class ScreenRouter<T extends ScreenRoutes> extends StatefulWidget {
  final String? initialRoute;

  _ScreenRouterState get _state => _expando[this]!;

  const ScreenRouter({
    this.initialRoute,
  });

  @override
  _ScreenRouterState createState() => _ScreenRouterState();

  Future<R?> push<R extends Object?>(String url, {bool modal = false, bool replace = false, bool clear = false}) {
    return _state.push(url, modal: modal, replace: replace, clear: clear);
  }

  void pop<R extends Object?>([R? result]) => _state.pop<R>(result);

  Future<bool> maybePop<R extends Object?>([R? result]) => _state.maybePop<R>(result);

  bool canPop() => _state.canPop();

  ScreenRouter<R> of<R extends ScreenRoutes>(BuildContext context) {
    return Dependency.resolve<ScreenRouter<R>>(context);
  }
}

class _ScreenRouterState<T extends ScreenRoutes> extends State<ScreenRouter<T>> {
  late final routes = Dependency.resolve<T>(context);

  final _navigatorKey = GlobalKey<NavigatorState>();
  late final ScreenRouter<T> _initialWidget;

  @override
  void initState() {
    super.initState();

    _expando[widget] = this;
    _initialWidget = widget;
  }

  @override
  void dispose() {
    super.dispose();
    _expando[_initialWidget] = null;
  }

  @override
  Widget build(BuildContext context) {
    final initialRoute = widget.initialRoute ?? routes.initialRoute;
    return Dependency<ScreenRouter>.value(
      value: _initialWidget,
      child: Dependency<ScreenRouter<T>>.value(
        value: _initialWidget,
        child: Navigator(
          key: _navigatorKey,
          initialRoute: initialRoute,
          reportsRouteUpdateToEngine: true,
          onGenerateInitialRoutes: (navigator, initialRoute) {
            return [];
          },
          onGenerateRoute: (settings) {
            final url = settings.name ?? initialRoute;
            final path = Uri.parse(url).path;
            final route = routes.matchRoute(path);
            if (route != null) {
              return MaterialPageRoute<dynamic>(
                builder: (context) {
                  return Dependency<ScreenRoute>(
                    create: () => ScreenRoute(url: url),
                    child: route.screen,
                  );
                },
                settings: settings,
              );
            }
          },
        ),
      ),
    );
  }

  Future<R?> push<R extends Object?>(String url, {bool modal = false, bool replace = false, bool clear = false}) {
    final path = Uri.parse(url).path;
    final route = routes.matchRoute(path);

    if (route == null) {
      final parent = context.findAncestorStateOfType<_ScreenRouterState>();
      if (parent == null) throw ScreenNotFoundException(url);
      return parent.push<R>(url);
    }

    final pageRoute = MaterialPageRoute<R>(
      builder: (context) {
        return Dependency<ScreenRoute>(
          create: () => ScreenRoute(url: url),
          child: route.screen,
        );
      },
      settings: RouteSettings(name: url),
      fullscreenDialog: modal,
    );

    final navigator = _navigatorKey.currentState!;
    if (clear) {
      return navigator.pushAndRemoveUntil<R>(pageRoute, (route) => false);
    } else if (replace) {
      return navigator.pushReplacement<R, Object?>(pageRoute);
    } else {
      return navigator.push<R>(pageRoute);
    }
  }

  void pop<R extends Object?>([R? result]) {
    final navigator = _navigatorKey.currentState!;
    navigator.pop<R>(result);
  }

  Future<bool> maybePop<R extends Object?>([R? result]) {
    final navigator = _navigatorKey.currentState!;
    return navigator.maybePop<R>(result);
  }

  bool canPop() {
    final navigator = _navigatorKey.currentState!;
    return navigator.canPop();
  }
}
