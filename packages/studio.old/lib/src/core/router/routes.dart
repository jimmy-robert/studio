import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as material;
import 'package:uri/uri.dart';

import '../injection/injection.dart';
import 'route_widget.dart';

class Route {
  final _params = <String, String>{};
  final _extras = <String, Object>{};

  final String name;
  final Widget Function() builder;

  Route._({
    this.name,
    this.builder,
    Map<String, String> params,
    Map<String, Object> extras,
  }) {
    _params.addAll(params);
    _extras.addAll(extras);
  }

  factory Route({
    Widget Function() builder,
    Map<String, Object> extras,
  }) {
    return Route._(name: '/', builder: builder, extras: extras);
  }

  String getParam(String name) => _params[name];
  T getExtra<T>(String name) => _extras[name] as T;
}

abstract class Routes with Injection {
  final initialRoute = '/';

  final _routes = <Route>[];
  var _alreadyRegistered = false;

  @override
  void onCreate() {
    super.onCreate();
    registerRoutes();
    _alreadyRegistered = true;
  }

  void registerRoutes();

  Route route({
    @required String name,
    @required Widget Function() builder,
    Map<String, String> params = const <String, String>{},
    Map<String, Object> extras = const <String, dynamic>{},
  }) {
    if (_alreadyRegistered) {
      for (final param in params.entries) {
        final template = '{${param.key}}';
        name = name.replaceAll(template, param.value);
      }
      final uriBuilder = UriBuilder.fromUri(Uri.parse(name));
      for (final param in params.entries) {
        if (param.value != null) {
          uriBuilder.queryParameters[param.key] = param.value;
        }
      }
      return Route._(
        name: uriBuilder.toString(),
        builder: builder,
        params: params,
        extras: extras,
      );
    }

    final route = Route._(
      name: name,
      builder: builder,
      params: params,
      extras: extras,
    );
    _routes.add(route);
    return route;
  }

  material.Route<T> onGenerateRoute<T>(RouteSettings settings, [Map<String, Object> extras]) {
    var _settings = settings;
    if (_settings.arguments is! Route) {
      final arguments = _buildRoute(_settings.name, extras);
      if (arguments == null) return onUnknownRoute<T>(_settings);

      _settings = _settings.copyWith(arguments: arguments);
    }

    final arguments = _settings.arguments;
    if (arguments is Route) {
      return MaterialPageRoute<T>(
        builder: (context) => RouteWidget(route: arguments),
        settings: _settings,
      );
    }

    throw Exception('Unreachable');
  }

  material.Route<T> onUnknownRoute<T>(RouteSettings settings) {
    return MaterialPageRoute<T>(
      builder: (context) => Container(color: Colors.pink), // todo
    );
  }

  Route _buildRoute(String name, Map<String, Object> extras) {
    for (final route in _routes) {
      final uri = Uri.parse(name);
      final match = _matchUri(route.name, uri.path);
      if (match != null) {
        final params = <String, String>{};
        for (final param in route._params.entries) {
          if (param.value != null) params[param.key] = param.value;
        }
        if (match.parameters != null) params.addAll(match.parameters);
        if (uri.queryParameters != null) params.addAll(uri.queryParameters);
        return Route._(
          name: name,
          builder: route.builder,
          params: params,
          extras: extras ?? <String, Object>{},
        );
      }
    }
    return null;
  }

  UriMatch _matchUri(String pattern, String path) {
    final template = UriTemplate(pattern);
    final parser = UriParser(template);
    final match = parser.match(Uri.parse(path));

    // Check `rest` property because of matcher behavior, for instance
    // "/" will match everything that starts with "/" ("/home", "/hello/world", ...)
    if (match != null && match.rest.pathSegments.isEmpty) {
      return match;
    }
    return null;
  }
}
