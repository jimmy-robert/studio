import 'package:back_button_interceptor/back_button_interceptor.dart';

import '../injection/injection.dart';
import 'router.dart';

class RouterBackController with Injection {
  @override
  void onCreate() {
    super.onCreate();
    BackButtonInterceptor.add(_onBackButton, ifNotYetIntercepted: true);
  }

  @override
  void onDispose() {
    BackButtonInterceptor.remove(_onBackButton);
    super.onDispose();
  }

  bool _onBackButton(bool stopDefaultButtonEvent, RouteInfo routeInfo) {
    final router = resolve<Router>();
    if (router == null || !router.enabled || !router.canPop()) {
      return false;
    }

    router.pop();
    return true;
  }
}
