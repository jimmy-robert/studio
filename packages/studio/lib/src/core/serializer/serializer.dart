import 'package:flutter/foundation.dart';

import '../../utils/type.dart';
import '../injection/resolver.dart';
import '../lifecycle/lifecycle.dart';

final _stringList = typeOf<List<String>>();
final _intList = typeOf<List<int>>();
final _doubleList = typeOf<List<double>>();
final _numList = typeOf<List<num>>();
final _boolList = typeOf<List<bool>>();
final _stringMap = typeOf<Map<String, String>>();
final _intMap = typeOf<Map<String, int>>();
final _doubleMap = typeOf<Map<String, double>>();
final _numMap = typeOf<Map<String, num>>();
final _boolMap = typeOf<Map<String, bool>>();

final _primitiveTypes = {
  String,
  int,
  double,
  num,
  bool,
  _stringList,
  _intList,
  _doubleList,
  _numList,
  _boolList,
  _stringMap,
  _intMap,
  _doubleMap,
  _numMap,
  _boolMap,
};

class Serializer {
  final _serializers = <Type, TypeSerializer>{};

  final _listSerializers = <Type, TypeSerializer>{};
  final _listGenerators = <Type, List Function()>{};

  final _mapSerializers = <Type, TypeSerializer>{};
  final _mapGenerators = <Type, Map<String, dynamic> Function()>{};

  bool canSerialize<T>() {
    if (_primitiveTypes.contains(T)) return true;
    if (_serializers.containsKey(T)) return true;
    if (_listSerializers.containsKey(T)) return true;
    if (_mapSerializers.containsKey(T)) return true;
    return false;
  }

  dynamic serialize<T>(T value) {
    if (value == null) return null;

    // Value

    var serializer = _serializers[T];
    if (serializer != null) {
      return serializer._serializeType(value);
    }

    // List

    serializer = _listSerializers[T];
    if (serializer != null) {
      assert(value is List);
      final values = value as List;
      return values.map<dynamic>((dynamic value) => serializer._serializeType(value)).toList();
    }

    // Map

    serializer = _mapSerializers[T];
    if (serializer != null) {
      assert(value is Map<String, dynamic>);
      final values = value as Map<String, dynamic>;
      return values.map<String, dynamic>((key, dynamic value) {
        return MapEntry<String, dynamic>(key, serializer._serializeType(value));
      });
    }

    return value;
  }

  T deserialize<T>(dynamic value) {
    if (value == null) return null;

    // Value

    var serializer = _serializers[T];
    if (serializer != null) {
      return serializer._deserializeType(value) as T;
    }

    // List

    serializer = _listSerializers[T];
    if (serializer != null) {
      assert(value is List);
      final values = value as List;
      final result = _listGenerators[T]();
      for (final dynamic value in values) {
        result.add(serializer._deserializeType(value));
      }
      return result as T;
    }

    // Map

    serializer = _mapSerializers[T];
    if (serializer != null) {
      assert(value is Map<String, dynamic>);
      final values = value as Map<String, dynamic>;
      final result = _mapGenerators[T]();
      for (final entry in values.entries) {
        result[entry.key] = serializer._deserializeType(entry.value);
      }
      return result as T;
    }

    // Primitive lists

    if (T == _stringList) {
      assert(value is List);
      return (value as List).cast<String>() as T;
    }
    if (T == _boolList) {
      assert(value is List);
      return (value as List).cast<bool>() as T;
    }
    if (T == _intList) {
      assert(value is List);
      return (value as List).cast<int>() as T;
    }
    if (T == _doubleList) {
      assert(value is List);
      return (value as List).cast<double>() as T;
    }
    if (T == _numList) {
      assert(value is List);
      return (value as List).cast<num>() as T;
    }

    // Primitive maps

    if (T == _stringMap) {
      assert(value is Map<String, dynamic>);
      return (value as Map<String, dynamic>).map<String, String>((key, dynamic value) {
        return MapEntry(key, value as String);
      }) as T;
    }
    if (T == _boolMap) {
      assert(value is Map<String, dynamic>);
      return (value as Map<String, dynamic>).map<String, bool>((key, dynamic value) {
        return MapEntry(key, value as bool);
      }) as T;
    }
    if (T == _intMap) {
      assert(value is Map<String, dynamic>);
      return (value as Map<String, dynamic>).map<String, int>((key, dynamic value) {
        return MapEntry(key, value as int);
      }) as T;
    }
    if (T == _doubleMap) {
      assert(value is Map<String, dynamic>);
      return (value as Map<String, dynamic>).map<String, double>((key, dynamic value) {
        return MapEntry(key, value as double);
      }) as T;
    }
    if (T == _numMap) {
      assert(value is Map<String, dynamic>);
      return (value as Map<String, dynamic>).map<String, num>((key, dynamic value) {
        return MapEntry(key, value as num);
      }) as T;
    }

    return value as T;
  }

  TypeSerializer<T> register<T>() {
    final listType = typeOf<List<T>>();
    _listGenerators[listType] = () => <T>[];

    final mapType = typeOf<Map<String, T>>();
    _mapGenerators[mapType] = () => <String, T>{};

    return _serializers[T] = _listSerializers[listType] = _mapSerializers[mapType] = TypeSerializer<T>._(this);
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

  void property<P>({
    @required String key,
    @required P Function(T instance) get,
    @required void Function(T instance, P value) set,
  }) {
    _properties.add(_Property<T, P>(
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

class _Property<T, P> {
  final Serializer serializer;

  final String key;
  final P Function(T instance) get;
  final void Function(T instance, P value) set;

  _Property({
    this.serializer,
    this.key,
    this.get,
    this.set,
  });

  dynamic serialize(T instance) {
    if (instance == null) return null;

    final value = get(instance);
    if (serializer.canSerialize<P>()) return serializer.serialize<P>(value);
    return value;
  }

  void deserialize(T instance, dynamic value) {
    if (value == null) return null;

    if (serializer.canSerialize<P>()) value = serializer.deserialize<P>(value);
    set(instance, value as P);
  }
}
