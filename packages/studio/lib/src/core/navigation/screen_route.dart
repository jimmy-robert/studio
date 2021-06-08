import 'package:studio/src/core/dependencies/dependency_resolver.dart';
import 'package:studio/studio.dart';

abstract class ScreenRoute {
  ScreenRoute._();

  factory ScreenRoute({
    required String url,
  }) = _ScreenRoute;

  String get url;

  String get path;

  String? query(String name);
}

class _ScreenRoute extends ScreenRoute with DependencyProxyResolver {
  final _queryParameters = <String, String>{};
  final Uri _url;

  _ScreenRoute({
    required String url,
  })  : _url = Uri.parse(url),
        super._();

  @override
  String get url => _url.toString();

  @override
  String get path => _url.path;

  @override
  String? query(String name) {
    if (_queryParameters.containsKey(name)) return _queryParameters[name];

    final parent = maybeResolve<ScreenRoute>();
    return parent?.query(name);
  }
}
