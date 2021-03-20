import '../router/router.dart';
import '../router/routes.dart';
import 'controller.dart';

class RouteController {
  final Controller controller;

  Route get _route => controller.resolve<Route>();

  const RouteController(this.controller);

  RouteController of<T extends Routes>() => _SpecificRouteController(controller);

  T getExtra<T>(String name) => _route.getExtra<T>(name);

  String getParam(String name) => _route.getParam(name);
}

class _SpecificRouteController<T extends Routes> extends RouteController {
  @override
  Route get _route => controller.resolve<Router<T>>().currentRoute;

  const _SpecificRouteController(Controller controller) : super(controller);
}
