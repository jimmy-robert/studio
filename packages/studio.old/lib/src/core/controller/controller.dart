import '../injection/injection.dart';
import 'route_controller.dart';
import 'router_controller.dart';

class Controller with Injection {
  RouterController router;
  RouteController route;

  @override
  void onCreate() {
    super.onCreate();
    router = RouterController(this);
    route = RouteController(this);
  }
}
