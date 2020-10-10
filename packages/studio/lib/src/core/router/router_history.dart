import 'package:flutter/material.dart' as material;

import 'routes.dart';

class RouterHistory extends material.NavigatorObserver {
  final _history = <material.Route<dynamic>>[];

  List<Route> get history => _history.map((route) {
        final arguments = route.settings.arguments;
        if (arguments is Route) return arguments;
        return null;
      }).toList();

  @override
  void didPush(material.Route route, material.Route previousRoute) {
    super.didPush(route, previousRoute);
    _history.add(route);
  }

  @override
  void didPop(material.Route route, material.Route previousRoute) {
    super.didPop(route, previousRoute);
    _history.removeLast();
  }

  @override
  void didRemove(material.Route route, material.Route previousRoute) {
    super.didRemove(route, previousRoute);
    _history.remove(route);
  }

  @override
  void didReplace({material.Route newRoute, material.Route oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    final index = _history.indexOf(oldRoute);
    _history
      ..removeAt(index)
      ..insert(index, newRoute);
  }
}
