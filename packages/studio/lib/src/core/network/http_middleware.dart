import 'dart:async';

import 'package:dio/dio.dart';

typedef RequestInterceptor = FutureOr<RequestOptions> Function(RequestOptions);
typedef ResponseInterceptor = FutureOr<Response> Function(Response);

class HttpMiddleware {
  const HttpMiddleware();

  const factory HttpMiddleware.builder({
    RequestInterceptor onRequest,
    ResponseInterceptor onResponse,
  }) = _HttpMiddleware;

  FutureOr<RequestOptions> onRequest(RequestOptions requestOptions) => requestOptions;

  FutureOr<Response> onResponse(Response response) => response;
}

class _HttpMiddleware extends HttpMiddleware {
  final RequestInterceptor _requestInterceptor;
  final ResponseInterceptor _responseInterceptor;

  const _HttpMiddleware({
    RequestInterceptor onRequest,
    ResponseInterceptor onResponse,
  })  : _requestInterceptor = onRequest,
        _responseInterceptor = onResponse;

  @override
  FutureOr<RequestOptions> onRequest(RequestOptions requestOptions) {
    if (_requestInterceptor != null) return _requestInterceptor(requestOptions);
    return super.onRequest(requestOptions);
  }

  @override
  FutureOr<Response> onResponse(Response response) {
    if (_responseInterceptor != null) return _responseInterceptor(response);
    return super.onResponse(response);
  }
}
