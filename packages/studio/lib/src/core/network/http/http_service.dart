import 'package:dio/dio.dart';
import 'package:studio/src/core/dependencies/dependency_resolver.dart';
import 'package:studio/src/core/lifecycle/lifecycle.dart';
import 'package:studio/src/core/network/http/http_headers.dart';
import 'package:studio/src/core/network/http/http_method.dart';
import 'package:studio/src/core/network/http/http_middleware.dart';
import 'package:studio/src/core/network/http/http_request.dart';
import 'package:studio/src/core/network/http/http_response.dart';
import 'package:studio/studio.dart';

typedef HttpProgressCallback = void Function(int, int);

class HttpService with DependencyProxyResolver, Lifecycle {
  final client = Dio();

  final middlewares = <HttpMiddleware>[];

  Future<HttpResponse> request({
    required HttpRequest request,
    HttpProgressCallback? onReceiveProgress,
    HttpProgressCallback? onSendProgress,
    HttpCancelToken? cancelToken,
  }) async {
    for (final middleware in middlewares.reversed) {
      request = await middleware.onRequest(request);
    }

    var response = await send(
      request: request,
      onReceiveProgress: onReceiveProgress,
      onSendProgress: onSendProgress,
      cancelToken: cancelToken,
    );

    for (final middleware in middlewares) {
      response = await middleware.onResponse(response);
    }

    return response;
  }

  Future<HttpResponse> send({
    required HttpRequest request,
    HttpProgressCallback? onReceiveProgress,
    HttpProgressCallback? onSendProgress,
    HttpCancelToken? cancelToken,
  }) async {
    final response = await client.request<String>(
      request.url.toString(),
      data: request.body,
      options: Options(
        method: request.method.name,
        headers: request.headers.toMap(),
        extra: request.extra,
        responseType: ResponseType.plain,
      ),
      onReceiveProgress: onReceiveProgress,
      onSendProgress: onSendProgress,
      cancelToken: cancelToken?._token,
    );
    return HttpResponse(
      statusCode: response.statusCode ?? 0,
      body: response.data ?? '',
      request: request,
      headers: HttpHeaders.fromMapList(response.headers.map),
    );
  }
}

class HttpCancelToken {
  final _token = CancelToken();

  void cancel() => _token.cancel();
}
