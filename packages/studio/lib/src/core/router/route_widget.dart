import 'package:flutter/material.dart' hide Route;

import '../injection/provider.dart';
import 'router_back_controller.dart';
import 'routes.dart';

class RouteWidget extends StatelessWidget {
  final Route route;

  const RouteWidget({this.route});

  @override
  Widget build(BuildContext context) {
    return Provider<RouterBackController>(
      () => RouterBackController(),
      lazy: false,
      child: Provider<Route>.value(route, child: route.builder()),
    );
  }
}
