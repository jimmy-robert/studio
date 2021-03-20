import 'package:dio/dio.dart';

class ApiException implements Exception {
  final Response response;
  final dynamic source;
  const ApiException({this.source, this.response});
}
