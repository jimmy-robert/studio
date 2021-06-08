enum HttpMethod {
  head,
  get,
  post,
  put,
  patch,
  delete,
}

extension HttpMethodExtension on HttpMethod {
  String get name {
    switch (this) {
      case HttpMethod.head:
        return 'HEAD';
      case HttpMethod.get:
        return 'GET';
      case HttpMethod.post:
        return 'POST';
      case HttpMethod.put:
        return 'PUT';
      case HttpMethod.patch:
        return 'PATCH';
      case HttpMethod.delete:
        return 'DELETE';
    }
  }
}
