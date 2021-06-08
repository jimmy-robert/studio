import 'dart:convert';

import 'package:studio/src/core/serializer/serializable.dart';
import 'package:studio/src/core/serializer/serialized.dart';
import 'package:studio/src/core/serializer/serializer.dart';
import 'package:studio/studio.dart';

class SerializationScope {
  final _serializers = <Type, Serializer>{};

  void register<T>(Serializer<T> serializer) {
    _serializers[T] = serializer;
    _serializers[typeOf<List<T>>()] = ListSerializer(serializer);
    _serializers[typeOf<List<T>?>()] = NullableSerializer<List<T>>(ListSerializer(serializer));
    _serializers[typeOf<Map<String, T>>()] = MapSerializer(serializer);
    _serializers[typeOf<Map<String, T>?>()] = NullableSerializer<Map<String, T>>(MapSerializer(serializer));

    // Stop here if T is already nullable
    if (isSubType<T, Object?>()) return;

    // T? (nullable)
    _serializers[typeOf<T?>()] = NullableSerializer<T>(serializer);
    _serializers[typeOf<List<T?>>()] = ListSerializer(NullableSerializer(serializer));
    _serializers[typeOf<List<T?>?>()] = NullableSerializer<List<T?>>(ListSerializer(NullableSerializer(serializer)));
    _serializers[typeOf<Map<String, T?>>()] = MapSerializer(NullableSerializer(serializer));
    _serializers[typeOf<Map<String, T?>?>()] =
        NullableSerializer<Map<String, T?>>(MapSerializer(NullableSerializer(serializer)));
  }

  T deserialize<T>(String value) {
    final serializer = _serializers[T];
    if (serializer is! Serializer<T>) throw Exception('todo');

    final serialized = _Serialized(data: jsonDecode(value), scope: this);
    return serializer.deserialize(serialized);
  }

  String serialize<T>(T value) {
    final serializer = _serializers[T];
    if (serializer is! Serializer<T>) throw Exception('todo');

    final serializable = serializer.serialize(value);
    if (serializable is SerializableValue) return jsonEncode(serializable.value);

    final result = <String, dynamic>{};
    for (final property in serializable.properties) {
      result[property.name] = _serializeProperty(property);
    }
    return jsonEncode(result);
  }

  dynamic _serializeProperty(SerializableProperty property) {
    final serializer = _serializers[property.type];
    if (serializer == null) throw Exception('todo');

    final serializable = serializer.serialize(property.value);
    return _serializeSerializable(serializable);
  }

  dynamic _serializeSerializable(Serializable serializable) {
    if (serializable is SerializableValue) return serializable.value;

    if (serializable is SerializableList) {
      return serializable.list.map<dynamic>(_serializeSerializable).toList();
    }

    final result = <String, dynamic>{};
    for (final property in serializable.properties) {
      result[property.name] = _serializeProperty(property);
    }
    return result;
  }
}

class _Serialized extends Serialized {
  @override
  final dynamic data;

  final SerializationScope scope;

  _Serialized({
    required this.data,
    required this.scope,
  });

  @override
  T get<T>(String name) {
    if (!scope._serializers.containsKey(T)) throw Exception('todo');
    final serializer = scope._serializers[T] as Serializer<T>;

    final dynamic data = this.data;
    if (data is! Map<String, dynamic>) throw Exception('todo');

    final dynamic value = data[name];
    final serialized = this.serialized(value);
    return serializer.deserialize(serialized);
  }

  @override
  Serialized serialized(dynamic data) {
    return _Serialized(data: data, scope: scope);
  }
}
