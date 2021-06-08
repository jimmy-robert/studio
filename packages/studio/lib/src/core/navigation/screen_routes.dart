import 'package:studio/src/core/dependencies/dependency_resolver.dart';
import 'package:studio/src/core/lifecycle/auto_create.dart';
import 'package:studio/src/core/lifecycle/lifecycle.dart';
import 'package:studio/src/core/navigation/screen_route.dart';
import 'package:studio/src/core/screen/screen.dart';

class ScreenRoutes with DependencyProxyResolver, Lifecycle, AutoCreate {
  String get initialRoute => _builders.first.path;

  late final ScreenRoutes _appRoutes = resolve();

  final _builders = <_ScreenRouteBuilder>[];

  final bool shouldMergeRoutes;

  ScreenRoutes({
    this.shouldMergeRoutes = true,
  });

  void route(String path, Screen screen) {
    final builder = _ScreenRouteBuilder(path, screen);
    _builders.add(builder);
    if (shouldMergeRoutes) _appRoutes._builders.add(builder);
  }

  _ScreenRouteBuilder? matchRoute(String path) {
    final index = _builders.indexWhere((route) => route.path == path || route.path == '*');
    if (index == -1) return null;
    return _builders[index];
  }
}

class _ScreenRouteBuilder {
  final String path;
  final Screen screen;

  const _ScreenRouteBuilder(this.path, this.screen);
}
