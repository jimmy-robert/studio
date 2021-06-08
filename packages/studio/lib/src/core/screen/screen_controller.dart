import 'package:studio/src/core/dependencies/dependency_resolver.dart';
import 'package:studio/src/core/lifecycle/lifecycle.dart';
import 'package:studio/src/core/navigation/screen_route.dart';
import 'package:studio/src/core/navigation/screen_router.dart';
import 'package:studio/src/core/navigation/screen_routes.dart';
import 'package:studio/src/core/reactive/subscriber.dart';

class ScreenController with DependencyProxyResolver, Lifecycle, Subscriber {
  ScreenRoute get route => resolve<ScreenRoute>();

  ScreenRouter get router => resolve<ScreenRouter>();

  ScreenRouter<T> routerOf<T extends ScreenRoutes>() => resolve<ScreenRouter<T>>();
}
