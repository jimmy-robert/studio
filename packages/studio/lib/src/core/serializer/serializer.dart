import '../../utils/type.dart';

class DefaultSerializer {
  final _serializers = <Type, Serializer>{};

  DefaultSerializer() {
    register<num>(const _NumSerializer());
    register<int>(const _IntSerializer());
    register<double>(const _DoubleSerializer());
    register<bool>(const _BoolSerializer());
    register<String>(const _StringSerializer());
    register<List<dynamic>>(const _DynamicListSerializer());
    register<Map<String, dynamic>>(const _DynamicMapSerializer());
  }

  T deserialize<T>(dynamic serialized) {
    if (serialized == null) return null;

    final serializer = _serializers[T] as Serializer<T>;
    if (serializer == null) return null;
    return serializer.deserialize(serialized);
  }

  dynamic serialize<T>(T value) {
    if (value == null) return null;

    final serializer = _serializers[T] as Serializer<T>;
    if (serializer == null) return null;
    return serializer.serialize(value);
  }

  void register<T>(Serializer<T> serializer) {
    if (serializer is _GetterSetterSerializer<T>) serializer._serializer = this;

    _serializers[T] = serializer;
    _serializers[typeOf<List<T>>()] = _ListSerialize(serializer);
    _serializers[typeOf<Map<String, T>>()] = _MapSerializer(serializer);
  }
}

abstract class Serializer<T> {
  T deserialize(dynamic serialized);
  dynamic serialize(T value);

  const Serializer._();

  factory Serializer({
    T Function(Getter getter) deserialize,
    void Function(Setter setter, T value) serialize,
  }) {
    return _GetterSetterSerializer<T>(deserialize, serialize);
  }
}

abstract class Getter {
  T call<T>(String name);
}

abstract class Setter {
  void call<T>(String name, T value);
}

class _Getter extends Getter {
  final DefaultSerializer _serializer;
  final dynamic _serialized;

  _Getter(this._serializer, this._serialized);

  @override
  T call<T>(String name) => _serializer.deserialize<T>(_serialized[name]);
}

class _Setter extends Setter {
  final DefaultSerializer _serializer;
  final data = <String, dynamic>{};

  _Setter(this._serializer);

  @override
  void call<T>(String name, T value) => data[name] = _serializer.serialize<T>(value);
}

class _GetterSetterSerializer<T> extends Serializer<T> {
  final T Function(Getter getter) _deserialize;
  final void Function(Setter setter, T value) _serialize;
  DefaultSerializer _serializer;

  _GetterSetterSerializer(this._deserialize, this._serialize) : super._();

  @override
  T deserialize(dynamic serialized) {
    if (serialized == null || _deserialize == null) return null;
    var getter = _Getter(_serializer, serialized);
    return _deserialize(getter);
  }

  @override
  dynamic serialize(T value) {
    if (value == null || _serialize == null) return null;
    var setter = _Setter(_serializer);
    return _serialize(setter, value);
  }
}

class _NumSerializer extends Serializer<num> {
  const _NumSerializer() : super._();

  @override
  num deserialize(dynamic serialized) {
    if (serialized is num) return serialized;
    return null;
  }

  @override
  dynamic serialize(num value) => value;
}

class _IntSerializer extends Serializer<int> {
  const _IntSerializer() : super._();

  @override
  int deserialize(dynamic serialized) {
    if (serialized is int) return serialized;
    if (serialized is num) return serialized.toInt();
    return null;
  }

  @override
  dynamic serialize(int value) => value;
}

class _DoubleSerializer extends Serializer<double> {
  const _DoubleSerializer() : super._();

  @override
  double deserialize(dynamic serialized) {
    if (serialized is double) return serialized;
    if (serialized is num) return serialized.toDouble();
    return null;
  }

  @override
  dynamic serialize(double value) => value;
}

class _BoolSerializer extends Serializer<bool> {
  const _BoolSerializer() : super._();

  @override
  bool deserialize(dynamic serialized) {
    if (serialized is bool) return serialized;
    return null;
  }

  @override
  dynamic serialize(bool value) => value;
}

class _StringSerializer extends Serializer<String> {
  const _StringSerializer() : super._();

  @override
  String deserialize(dynamic serialized) {
    if (serialized is String) return serialized;
    return null;
  }

  @override
  dynamic serialize(String value) => value;
}

class _ListSerialize<T> extends Serializer<List<T>> {
  final Serializer<T> _serializer;

  _ListSerialize(this._serializer) : super._();

  @override
  List<T> deserialize(dynamic serialized) {
    if (serialized is List) return serialized.map((dynamic item) => _serializer.deserialize(item)).toList();
    return null;
  }

  @override
  dynamic serialize(List<T> value) {
    return value.map<dynamic>((item) => _serializer.serialize(item)).toList();
  }
}

class _MapSerializer<T> extends Serializer<Map<String, T>> {
  final Serializer<T> _serializer;

  _MapSerializer(this._serializer) : super._();

  @override
  Map<String, T> deserialize(dynamic serialized) {
    if (serialized is Map<String, dynamic>) {
      return serialized.map((key, dynamic item) => MapEntry(key, _serializer.deserialize(item)));
    }
    return null;
  }

  @override
  dynamic serialize(Map<String, T> value) {
    return value.map<String, dynamic>((key, item) => MapEntry<String, dynamic>(key, _serializer.serialize(item)));
  }
}

class _DynamicListSerializer extends Serializer<List<dynamic>> {
  const _DynamicListSerializer() : super._();

  @override
  List<dynamic> deserialize(dynamic serialized) {
    if (serialized is List<dynamic>) return serialized;
    return null;
  }

  @override
  dynamic serialize(List<dynamic> value) => value;
}

class _DynamicMapSerializer extends Serializer<Map<String, dynamic>> {
  const _DynamicMapSerializer() : super._();

  @override
  Map<String, dynamic> deserialize(dynamic serialized) {
    if (serialized is Map<String, dynamic>) return serialized;
    return null;
  }

  @override
  dynamic serialize(Map<String, dynamic> value) => value;
}
