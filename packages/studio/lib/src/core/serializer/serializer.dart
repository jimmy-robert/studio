import 'package:studio/src/core/serializer/serializable.dart';
import 'package:studio/src/core/serializer/serialization_scope.dart';
import 'package:studio/src/core/serializer/serialized.dart';
import 'package:studio/studio.dart';

abstract class Serializer<T> with DependencyProxyResolver, Lifecycle, AutoCreate {
  T deserialize(Serialized value);
  Serializable serialize(T value);

  @override
  void onCreate() {
    super.onCreate();

    resolve<SerializationScope>().register<T>(this);
  }
}

class NullableSerializer<T> extends Serializer<T?> {
  final Serializer<T> serializer;

  NullableSerializer(this.serializer);

  @override
  T? deserialize(Serialized value) {
    if (value.data == null) return null;
    return serializer.deserialize(value);
  }

  @override
  Serializable serialize(T? value) {
    if (value == null) return SerializableValue(null);
    return serializer.serialize(value);
  }
}

class ListSerializer<T> extends Serializer<List<T>> {
  final Serializer<T> serializer;

  ListSerializer(this.serializer);

  @override
  List<T> deserialize(Serialized value) {
    final dynamic data = value.data;
    if (data is! List<dynamic>) throw Exception('todo');
    return data.map((dynamic item) => serializer.deserialize(value.serialized(item))).toList();
  }

  @override
  Serializable serialize(List<T> value) {
    return SerializableList(value.map((item) => serializer.serialize(item)).toList());
  }
}

class MapSerializer<T> extends Serializer<Map<String, T>> {
  final Serializer<T> serializer;

  MapSerializer(this.serializer);

  @override
  Map<String, T> deserialize(Serialized value) {
    final dynamic data = value.data;
    if (data is! Map<String, dynamic>) throw Exception('todo');
    return data.map((key, dynamic item) => MapEntry(key, serializer.deserialize(value.serialized(item))));
  }

  @override
  Serializable serialize(Map<String, T> value) {
    final serializable = Serializable();
    value.forEach((name, value) => serializable.set<T>(name, value));
    return serializable;
  }
}

class NumSerializer extends Serializer<num> {
  @override
  num deserialize(Serialized value) {
    final dynamic data = value.data;
    if (data is num) return data;
    throw Exception('todo');
  }

  @override
  Serializable serialize(num value) {
    return SerializableValue(value);
  }
}

class IntSerializer extends Serializer<int> {
  @override
  int deserialize(Serialized value) {
    final dynamic data = value.data;
    if (data is num) return data.toInt();
    throw Exception('todo');
  }

  @override
  Serializable serialize(int value) {
    return SerializableValue<num>(value);
  }
}

class DoubleSerializer extends Serializer<double> {
  @override
  double deserialize(Serialized value) {
    final dynamic data = value.data;
    if (data is num) return data.toDouble();
    throw Exception('todo');
  }

  @override
  Serializable serialize(double value) {
    return SerializableValue<num>(value);
  }
}

class BoolSerializer extends Serializer<bool> {
  @override
  bool deserialize(Serialized value) {
    final dynamic data = value.data;
    if (data is bool) return data;
    throw Exception('todo');
  }

  @override
  Serializable serialize(bool value) {
    return SerializableValue(value);
  }
}

class StringSerializer extends Serializer<String> {
  @override
  String deserialize(Serialized value) {
    final dynamic data = value.data;
    if (data is String) return data;
    throw Exception('todo');
  }

  @override
  Serializable serialize(String value) {
    return SerializableValue(value);
  }
}
