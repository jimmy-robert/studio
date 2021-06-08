abstract class Serialized {
  dynamic get data;

  T get<T>(String name);

  Serialized serialized(dynamic data);
}
