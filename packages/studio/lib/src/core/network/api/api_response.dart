import 'package:studio/src/core/network/http/http_response.dart';

class ApiResponse<T> {
  final T data;
  final HttpResponse response;

  ApiResponse({
    required this.data,
    required this.response,
  });
}
