import 'package:dio/dio.dart';

import '../injection/resolver.dart';
import '../lifecycle/lifecycle.dart';
import '../serializer/serializer.dart';
import 'api_exception.dart';
import 'http_service.dart';

class Api with Lifecycle, ProxyResolver {
  HttpService _httpService;
  Serializer _serializer;

  HttpService get http => _httpService;

  @override
  void onCreate() {
    super.onCreate();
    _httpService = resolve<HttpService>();
    _serializer = resolve<Serializer>();
  }

  Future<T> get<T>(
    String path, {
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onReceiveProgress,
  }) async {
    final response = await _httpService.get<dynamic>(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
    return parseResponse<T>(response);
  }

  Future<T> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onSendProgress,
    ProgressCallback onReceiveProgress,
  }) async {
    final response = await _httpService.post<dynamic>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
    return parseResponse<T>(response);
  }

  Future<T> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onSendProgress,
    ProgressCallback onReceiveProgress,
  }) async {
    final response = await _httpService.put<dynamic>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
    return parseResponse<T>(response);
  }

  Future<T> head<T>(
    String path, {
    dynamic data,
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
  }) async {
    final response = await _httpService.head<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
    return parseResponse<T>(response);
  }

  Future<T> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
  }) async {
    final response = await _httpService.delete<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
    return parseResponse<T>(response);
  }

  Future<T> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onSendProgress,
    ProgressCallback onReceiveProgress,
  }) async {
    final response = await _httpService.patch<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
    return parseResponse<T>(response);
  }

  Future<Response> download(
    String urlPath,
    dynamic savePath, {
    ProgressCallback onReceiveProgress,
    Map<String, dynamic> queryParameters,
    CancelToken cancelToken,
    bool deleteOnError = true,
    String lengthHeader = Headers.contentLengthHeader,
    dynamic data,
    Options options,
  }) {
    return _httpService.download(
      urlPath,
      savePath,
      onReceiveProgress: onReceiveProgress,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      deleteOnError: deleteOnError,
      lengthHeader: lengthHeader,
      data: data,
      options: options,
    );
  }

  Future<T> request<T>(
    String path, {
    dynamic data,
    Map<String, dynamic> queryParameters,
    CancelToken cancelToken,
    Options options,
    ProgressCallback onSendProgress,
    ProgressCallback onReceiveProgress,
  }) async {
    final response = await _httpService.request<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      options: options,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
    return parseResponse<T>(response);
  }

  T parseResponse<T>(Response response, {bool Function(Response response) isError}) {
    isError ??= _isError;
    if (isError(response)) throw ApiException(response: response);
    try {
      final dynamic data = response.data;
      if (T == String && data is String) return data as T;
      return _serializer.deserialize<T>(data);
    } catch (exception) {
      throw ApiException(source: exception, response: response);
    }
  }

  static bool _isError(Response response) {
    return response == null || response.statusCode >= 400;
  }
}
