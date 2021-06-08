import 'package:studio/src/core/dependencies/dependency_resolver.dart';
import 'package:studio/src/core/lifecycle/auto_create.dart';
import 'package:studio/src/core/lifecycle/lifecycle.dart';
import 'package:studio/src/core/network/http/http_request.dart';
import 'package:studio/src/core/network/http/http_response.dart';

class HttpMiddleware with DependencyProxyResolver, Lifecycle, AutoCreate {
  Future<HttpRequest> onRequest(HttpRequest request) async {
    return request;
  }

  Future<HttpResponse> onResponse(HttpResponse response) async {
    return response;
  }
}
