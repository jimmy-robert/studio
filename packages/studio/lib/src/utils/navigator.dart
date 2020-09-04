import 'package:flutter/material.dart';

extension NavigatorExtension on NavigatorState {
  Future<T> pushMaterial<T>({
    WidgetBuilder builder,
    RouteSettings settings,
    bool fullscreenDialog,
    bool maintainState,
  }) {
    final route = MaterialPageRoute<T>(
      builder: builder,
      settings: settings,
      fullscreenDialog: fullscreenDialog,
      maintainState: maintainState,
    );
    return push(route);
  }
}
