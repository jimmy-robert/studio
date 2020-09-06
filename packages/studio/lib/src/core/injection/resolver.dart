mixin Resolver {
  T resolve<T>({bool allowNull = true});
}

mixin ProxyResolver {
  Resolver resolver;
  T resolve<T>({bool allowNull = true}) => resolver.resolve<T>(allowNull: allowNull);
}
