import 'package:studio/src/core/network/http/http_headers.dart';
import 'package:studio/src/core/network/http/http_method.dart';

class HttpRequest {
  Uri url;
  HttpMethod method;
  HttpHeaders headers;
  dynamic body;
  Map<String, dynamic> extra;

  HttpRequest({
    required this.url,
    HttpMethod? method,
    dynamic body,
    HttpHeaders? headers,
    Map<String, dynamic>? extra,
  })  : method = method ?? HttpMethod.get,
        headers = headers ?? HttpHeaders(),
        body = body,
        extra = extra ?? <String, String>{};
}
