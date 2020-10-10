import 'package:flutter/cupertino.dart' hide Route;
import 'package:flutter/material.dart' hide Route;
import 'package:flutter/material.dart' as material;

import '../injection/provider.dart';
import 'route_widget.dart';
import 'router_history.dart';
import 'routes.dart';

class Router<T extends Routes> extends StatefulWidget {
  final String initialRoute;
  final _stateHolder = _StateHolder<T>();
  final bool _enabled;

  Router({Key key, this.initialRoute, bool enabled})
      : _enabled = enabled,
        super(key: key);

  @override
  _RouterState<T> createState() => _RouterState<T>();

  bool get enabled => _stateHolder.state._enabled;
  set enabled(bool value) => _stateHolder.state._enabled;

  Route get currentRoute => _stateHolder.state.currentRoute;

  Future<U> push<U extends Object>(
    dynamic route, {
    bool clear = false,
    bool replace = false,
    dynamic replaceResult,
    RoutePredicate removeUntil,
    bool maintainState,
    bool modal,
    Map<String, Object> extras,
  }) {
    return _stateHolder.state.push<U>(
      route,
      clear: clear,
      replace: replace,
      replaceResult: replaceResult,
      removeUntil: removeUntil,
      maintainState: maintainState,
      modal: modal,
      extras: extras,
    );
  }

  bool pop({
    dynamic result,
    bool toRoot = false,
    RoutePredicate until,
  }) {
    return _stateHolder.state.pop(
      result: result,
      toRoot: toRoot,
      until: until,
    );
  }

  bool canPop() => _stateHolder.state.canPop();

  Future<bool> maybePop({dynamic result}) => _stateHolder.state.maybePop(result: result);

  void replace<U>({
    @required material.Route<dynamic> oldRoute,
    @required material.Route<U> newRoute,
  }) {
    _stateHolder.state.replace(oldRoute: oldRoute, newRoute: newRoute);
  }

  void replaceBelow<U>({
    @required material.Route<dynamic> anchorRoute,
    @required material.Route<U> newRoute,
  }) {
    _stateHolder.state.replaceBelow(anchorRoute: anchorRoute, newRoute: newRoute);
  }

  Future<U> showDialog<U>({
    @required WidgetBuilder builder,
    bool barrierDismissible = true,
  }) {
    return _stateHolder.state.showDialog(
      builder: builder,
      barrierDismissible: barrierDismissible,
    );
  }
}

class _RouterState<T extends Routes> extends State<Router<T>> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  final _history = RouterHistory();

  Router<T> _initialRouter;

  Route get currentRoute => _history.history.last;

  T _routes;
  T get routes => _routes;

  bool _enabled;
  bool get enabled {
    final parent = context.resolve<Router>();
    if (parent != null && !parent.enabled) return false;
    return _enabled;
  }

  @override
  void initState() {
    super.initState();
    _initialRouter = widget;
    _initialRouter._stateHolder.state = this;
    _enabled = widget._enabled;
  }

  @override
  void dispose() {
    _initialRouter._stateHolder.state = null;
    _initialRouter = null;
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant Router<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    _enabled = widget._enabled;
  }

  @override
  Widget build(BuildContext context) {
    _routes = context.resolve<T>();
    return Provider<Router>.value(
      _initialRouter,
      child: Provider<Router<T>>.value(
        _initialRouter,
        child: Navigator(
          key: _navigatorKey,
          initialRoute: widget.initialRoute ?? _routes.initialRoute,
          onGenerateRoute: _routes.onGenerateRoute,
          onUnknownRoute: _routes.onUnknownRoute,
          observers: [_history],
        ),
      ),
    );
  }

  Future<U> push<U>(
    dynamic route, {
    bool clear = false,
    bool replace = false,
    dynamic replaceResult,
    RoutePredicate removeUntil,
    bool maintainState,
    bool modal,
    Map<String, Object> extras,
  }) {
    if (route is String) {
      final name = route as String;
      route = RouteSettings(name: name);
    }
    if (route is RouteSettings) {
      final settings = route as RouteSettings;
      route = _routes.onGenerateRoute<U>(settings, extras) ?? _routes.onUnknownRoute<U>(settings);
    }
    if (route is Widget) {
      final widget = route as Widget;
      route = Route(builder: () => widget, extras: extras);
    }
    if (route is WidgetBuilder) {
      final builder = route as WidgetBuilder;
      route = Route(
        builder: () => Builder(builder: builder),
        extras: extras,
      );
    }
    if (route is Route) {
      final _route = route as Route;
      route = material.MaterialPageRoute<T>(
        builder: (context) => RouteWidget(route: _route),
        settings: RouteSettings(name: _route.name, arguments: _route),
      );
    }
    assert(
      route is material.Route<U>,
      'Invalid `route` parameter: (${route.runtimeType}) $route. '
      'The `route` must be either a `String`, `RouteSettings`, `Route`, `Widget` or `WidgetBuilder`.',
    );

    if (modal != null || maintainState != null) {
      if (route is MaterialPageRoute<U>) {
        final material = route as MaterialPageRoute<U>;
        route = MaterialPageRoute<U>(
          fullscreenDialog: modal ?? material.fullscreenDialog,
          maintainState: maintainState ?? material.maintainState,
          builder: material.builder,
          settings: material.settings,
        );
      } else if (route is CupertinoPageRoute) {
        final cupertino = route as CupertinoPageRoute<U>;
        route = CupertinoPageRoute<U>(
          fullscreenDialog: modal ?? cupertino.fullscreenDialog,
          maintainState: maintainState ?? cupertino.maintainState,
          builder: cupertino.builder,
          settings: cupertino.settings,
          title: cupertino.title,
        );
      }

      // Errors
      if (route is! MaterialPageRoute<U> && route is! CupertinoPageRoute<U>) {
        if (modal != null) {
          throw Exception('Cannot apply `modal` for this route ${route.runtimeType}');
        } else {
          throw Exception('Cannot apply `maintainState` for this route ${route.runtimeType}');
        }
      }
    }

    final _route = route as material.Route<U>;
    final navigator = _navigatorKey.currentState;
    if (clear) return navigator.pushAndRemoveUntil<U>(_route, (route) => false);
    if (removeUntil != null) return navigator.pushAndRemoveUntil<U>(_route, removeUntil);
    if (replace) return navigator.pushReplacement<U, dynamic>(_route, result: replaceResult);
    return navigator.push<U>(_route);
  }

  bool pop({
    dynamic result,
    bool toRoot = false,
    RoutePredicate until,
  }) {
    final navigator = _navigatorKey.currentState;
    if (toRoot) {
      var popped = false;
      navigator.popUntil((route) {
        if (!popped) popped = !route.isFirst;
        return route.isFirst;
      });
      return popped;
    }
    if (until != null) {
      var popped = false;
      navigator.popUntil((route) {
        final popResult = until(route);
        if (!popped) popped = !popResult;
        return popResult;
      });
      return popped;
    }

    navigator.pop<dynamic>(result);
    return true;
  }

  bool canPop() => _navigatorKey.currentState.canPop();

  Future<bool> maybePop({dynamic result}) {
    return _navigatorKey.currentState.maybePop<dynamic>(result);
  }

  void replace<U>({
    @required material.Route<dynamic> oldRoute,
    @required material.Route<U> newRoute,
  }) {
    _navigatorKey.currentState.replace(oldRoute: oldRoute, newRoute: newRoute);
  }

  void replaceBelow<U>({
    @required material.Route<dynamic> anchorRoute,
    @required material.Route<U> newRoute,
  }) {
    _navigatorKey.currentState.replaceRouteBelow(
      anchorRoute: anchorRoute,
      newRoute: newRoute,
    );
  }

  Future<U> showDialog<U>({
    @required WidgetBuilder builder,
    bool barrierDismissible = true,
  }) {
    final theme = Theme.of(context, shadowThemeOnly: true);
    final route = _DialogRoute<U>(
      pageBuilder: (buildContext, animation, secondaryAnimation) {
        final child = Builder(builder: builder);
        return SafeArea(
          child: theme != null ? Theme(data: theme, child: child) : child,
        );
      },
      barrierDismissible: barrierDismissible,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 150),
      transitionBuilder: _buildMaterialDialogTransitions,
    );
    return _navigatorKey.currentState.push<U>(route);
  }
}

class _StateHolder<T extends Routes> {
  _RouterState<T> state;
}

// Dialog

Widget _buildMaterialDialogTransitions(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return FadeTransition(
    opacity: CurvedAnimation(
      parent: animation,
      curve: Curves.easeOut,
    ),
    child: child,
  );
}

class _DialogRoute<T> extends PopupRoute<T> {
  _DialogRoute({
    @required RoutePageBuilder pageBuilder,
    bool barrierDismissible = true,
    String barrierLabel,
    Color barrierColor = const Color(0x80000000),
    Duration transitionDuration = const Duration(milliseconds: 200),
    RouteTransitionsBuilder transitionBuilder,
    RouteSettings settings,
  })  : assert(barrierDismissible != null, 'barrierDismissible is mandatory'),
        _pageBuilder = pageBuilder,
        _barrierDismissible = barrierDismissible,
        _barrierLabel = barrierLabel,
        _barrierColor = barrierColor,
        _transitionDuration = transitionDuration,
        _transitionBuilder = transitionBuilder,
        super(settings: settings);

  final RoutePageBuilder _pageBuilder;

  @override
  bool get barrierDismissible => _barrierDismissible;
  final bool _barrierDismissible;

  @override
  String get barrierLabel => _barrierLabel;
  final String _barrierLabel;

  @override
  Color get barrierColor => _barrierColor;
  final Color _barrierColor;

  @override
  Duration get transitionDuration => _transitionDuration;
  final Duration _transitionDuration;

  final RouteTransitionsBuilder _transitionBuilder;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return Semantics(
      scopesRoute: true,
      explicitChildNodes: true,
      child: _pageBuilder(context, animation, secondaryAnimation),
    );
  }

  @override
  Widget buildTransitions(
      BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    if (_transitionBuilder == null) {
      return FadeTransition(
        opacity: CurvedAnimation(
          parent: animation,
          curve: Curves.linear,
        ),
        child: child,
      );
    } // Some default transition
    return _transitionBuilder(context, animation, secondaryAnimation, child);
  }
}
