import 'package:flutter/material.dart';

extension NavigatorExtension on NavigatorState {
  Future<T> pushWidget<T>({WidgetBuilder builder}) {
    final route = MaterialPageRoute<T>(builder: builder);
    return push(route);
  }
}
