import 'dart:convert';
import 'dart:io';

import '../serializer/serializer.dart';

class Store<T> {
  final Serializer serializer;
  final String name;

  T value;

  Store(
    this.name, {
    this.serializer,
  }) : assert(T == String || serializer != null);

  Future load() async {
    final file = File(name);
    if (!await file.exists()) return;
    final data = await File(name).readAsString();

    if (T == String) {
      value = data as T;
    } else {
      value = serializer.deserialize<T>(jsonDecode(data));
    }
  }

  Future save() async {
    final file = File(name);
    String data;
    if (T == String) {
      data = value as String;
    } else {
      data = jsonEncode(serializer.serialize<T>(value));
    }
    await file.writeAsString(data);
  }
}
