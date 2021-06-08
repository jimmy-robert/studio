import 'package:studio/src/core/dependencies/dependency_resolver.dart';
import 'package:studio/src/core/network/api/api_response.dart';
import 'package:studio/src/core/network/http/http_request.dart';
import 'package:studio/src/core/network/http/http_service.dart';
import 'package:studio/src/core/serializer/serialization_scope.dart';

class Api with DependencyProxyResolver {
  late final HttpService httpService = resolve();
  late final SerializationScope serializationScope = resolve();

  Future<ApiResponse<T>> request<T>({
    required HttpRequest request,
    HttpCancelToken? cancelToken,
    HttpProgressCallback? onReceiveProgress,
    HttpProgressCallback? onSendProgress,
  }) async {
    final response = await httpService.request(
      request: request,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
      onSendProgress: onSendProgress,
    );
    return ApiResponse(
      data: serializationScope.deserialize<T>(response.body),
      response: response,
    );
  }
}
