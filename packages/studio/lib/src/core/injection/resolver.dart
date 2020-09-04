mixin Resolver {
  T get<T>({bool allowNull = true});
}

mixin ProxyResolver {
  Resolver resolver;
  T get<T>({bool allowNull = true}) => resolver.get<T>(allowNull: allowNull);
}
