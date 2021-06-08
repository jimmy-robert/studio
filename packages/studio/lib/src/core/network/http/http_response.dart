import 'package:studio/src/core/network/http/http_headers.dart';
import 'package:studio/src/core/network/http/http_request.dart';

class HttpResponse {
  int statusCode;

  String body;

  HttpHeaders headers = HttpHeaders();

  HttpRequest request;

  HttpResponse({
    required this.statusCode,
    required this.body,
    required this.request,
    HttpHeaders? headers,
  }) : headers = headers ?? HttpHeaders();
}
