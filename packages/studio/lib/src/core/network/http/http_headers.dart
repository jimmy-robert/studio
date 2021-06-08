class HttpHeaders {
  final _headers = <String, List<String>>{};

  HttpHeaders();

  factory HttpHeaders.fromMap(Map<String, String> map) {
    final headers = HttpHeaders();
    map.forEach((name, value) => headers.add(name, value));
    return headers;
  }

  factory HttpHeaders.fromMapList(Map<String, List<String>> map) {
    final headers = HttpHeaders();
    map.forEach((name, values) {
      values.forEach((value) => headers.add(name, value));
    });
    return headers;
  }

  List<String> get keys => _headers.keys.toList();

  String? value(String name) {
    final values = this.values(name.toLowerCase()) ?? [];
    return values.isEmpty ? null : values.first;
  }

  List<String>? values(String name) => _headers[name.toLowerCase()];

  void add(String name, String value) {
    var values = _headers[name.toLowerCase()];
    if (values == null) {
      values = [];
      _headers[name.toLowerCase()] = values;
    }
    return values.add(value);
  }

  void remove(String name, String value) => _headers[name.toLowerCase()]?.remove(value);

  void removeAll(String name) => _headers[name.toLowerCase()]?.clear();

  void clear() => _headers.clear();

  Map<String, List<String>> toMap() => Map.of(_headers);
}
