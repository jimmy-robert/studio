import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' as material;

import '../router/router.dart';
import '../router/routes.dart';
import 'controller.dart';

class RouterController {
  final Controller controller;

  Router get _router => controller.resolve<Router>();

  const RouterController(this.controller);

  RouterController of<T extends Routes>() => _SpecificRouterController(controller);

  Future<U> push<U extends Object>(
    dynamic route, {
    bool clear = false,
    bool replace = false,
    dynamic replaceResult,
    material.RoutePredicate removeUntil,
    bool maintainState,
    bool modal,
    Map<String, Object> extras,
  }) {
    return _router.push<U>(
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
    material.RoutePredicate until,
  }) {
    return _router.pop(
      result: result,
      toRoot: toRoot,
      until: until,
    );
  }

  bool canPop() => _router.canPop();

  Future<bool> maybePop({dynamic result}) => _router.maybePop(result: result);

  void replace<T>({
    @required material.Route<dynamic> oldRoute,
    @required material.Route<T> newRoute,
  }) {
    _router.replace(oldRoute: oldRoute, newRoute: newRoute);
  }

  void replaceBelow<T>({
    @required material.Route<dynamic> anchorRoute,
    @required material.Route<T> newRoute,
  }) {
    _router.replaceBelow<T>(anchorRoute: anchorRoute, newRoute: newRoute);
  }

  Future<T> showDialog<T>({
    @required material.WidgetBuilder builder,
    bool barrierDismissible = true,
  }) {
    return _router.showDialog(
      builder: builder,
      barrierDismissible: barrierDismissible,
    );
  }
}

class _SpecificRouterController<T extends Routes> extends RouterController {
  @override
  Router get _router => controller.resolve<Router<T>>();

  const _SpecificRouterController(Controller controller) : super(controller);
}
