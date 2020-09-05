import 'package:flutter/foundation.dart';

import '../injection/resolver.dart';
import '../lifecycle/lifecycle.dart';

class Serializer {
  final _serializers = <Type, TypeSerializer>{};

  bool canSerialize<T>() => _serializers.containsKey(T);

  dynamic serialize<T>(T value) {
    if (value == null) return null;

    final serializer = _serializers[T];
    assert(serializer != null);

    return serializer._serializeType(value);
  }

  dynamic serializeList<T>(List<T> values) {
    if (values == null) return null;

    final serializer = _serializers[T];
    assert(serializer != null);

    return values.map<dynamic>((value) => serializer._serializeType(value)).toList();
  }

  T deserialize<T>(dynamic value) {
    if (value == null) return null;

    final serializer = _serializers[T] as TypeSerializer<T>;
    assert(serializer != null);

    return serializer._deserializeType(value);
  }

  List<T> deserializeList<T>(dynamic values) {
    if (values == null) return null;

    final serializer = _serializers[T] as TypeSerializer<T>;
    assert(serializer != null);

    final list = values as List;
    return list.map((dynamic data) => serializer._deserializeType(data)).toList();
  }

  TypeSerializer<T> register<T>() {
    return _serializers[T] = TypeSerializer<T>._(this);
  }
}

class DefaultSerializer extends Serializer with Lifecycle, ProxyResolver {}

class TypeSerializer<T> {
  final Serializer _serializer;

  dynamic Function(T data) _serialize;
  T Function(dynamic data) _deserialize;
  T Function() _create;
  final _properties = <_Property>[];

  TypeSerializer._(this._serializer);

  void serialize(dynamic Function(T instance) serialize) => _serialize = serialize;

  void deserialize(T Function(dynamic data) deserialize) => _deserialize = deserialize;

  void create(T Function() create) => _create = create;

  void value<P>({
    @required String key,
    @required P Function(T instance) get,
    @required void Function(T instance, P value) set,
  }) {
    _properties.add(_PropertyValue<T, P>(
      serializer: _serializer,
      key: key,
      get: get,
      set: set,
    ));
  }

  void list<P>({
    @required String key,
    @required List<P> Function(T instance) get,
    @required void Function(T instance, List<P> value) set,
  }) {
    _properties.add(_PropertyList<T, P>(
      serializer: _serializer,
      key: key,
      get: get,
      set: set,
    ));
  }

  dynamic _serializeType(T instance) {
    if (instance == null) return null;

    if (_serialize != null) return _serialize(instance);

    final result = <String, dynamic>{};
    for (final property in _properties) {
      result[property.key] = property.serialize(instance);
      ;
    }
    return result;
  }

  T _deserializeType(dynamic data) {
    if (data == null) return null;

    assert(_deserialize != null || _create != null);

    if (_deserialize != null) return _deserialize(data);

    final instance = _create();
    for (final property in _properties) {
      property.deserialize(instance, data[property.key]);
    }
    return instance;
  }
}

abstract class _Property<T, P> {
  String get key;
  dynamic serialize(T instance);
  void deserialize(T instance, dynamic value);
}

class _PropertyValue<T, P> extends _Property<T, P> {
  final Serializer serializer;

  @override
  final String key;
  final P Function(T instance) get;
  final void Function(T instance, P value) set;

  _PropertyValue({
    this.serializer,
    this.key,
    this.get,
    this.set,
  });

  @override
  dynamic serialize(T instance) {
    if (instance == null) return null;

    final value = get(instance);
    if (serializer.canSerialize<P>()) return serializer.serialize<P>(value);
    return value;
  }

  @override
  void deserialize(T instance, dynamic value) {
    if (value == null) return null;

    if (serializer.canSerialize<P>()) value = serializer.deserialize<P>(value);
    try {
      assert(value is P);
    } catch (e) {
      print(e);
    }
    set(instance, value as P);
  }
}

class _PropertyList<T, P> extends _Property<T, List<P>> {
  final Serializer serializer;

  @override
  final String key;
  final List<P> Function(T instance) get;
  final void Function(T instance, List<P> value) set;

  _PropertyList({
    this.serializer,
    this.key,
    this.get,
    this.set,
  });

  @override
  dynamic serialize(T instance) {
    final values = get(instance);
    if (serializer.canSerialize<P>()) return serializer.serializeList<P>(values);
    return values;
  }

  @override
  void deserialize(T instance, dynamic value) {
    if (serializer.canSerialize<P>()) value = serializer.deserializeList<P>(value);
    assert(value is List<P>);
    set(instance, value as List<P>);
  }
}
