import 'resolver.dart';

mixin Proxy {
  Resolver resolver;
  T get<T>({bool allowNull = true}) => resolver.get<T>(allowNull: allowNull);
}
