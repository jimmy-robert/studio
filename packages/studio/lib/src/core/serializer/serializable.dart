class Serializable {
  final properties = <SerializableProperty>[];

  void set<T>(String name, T value) {
    properties.add(SerializableProperty<T>(name: name, value: value));
  }
}

class SerializableValue<T> extends Serializable {
  Type get type => T;

  final T value;

  SerializableValue(this.value);
}

class SerializableList extends Serializable {
  final List<Serializable> list;

  SerializableList(this.list);
}

class SerializableProperty<T> {
  Type get type => T;

  final String name;
  final T value;

  const SerializableProperty({
    required this.name,
    required this.value,
  });
}
