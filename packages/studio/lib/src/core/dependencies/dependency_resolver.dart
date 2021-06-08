mixin DependencyResolver {
  T resolve<T>();
  T? maybeResolve<T>();
}

mixin DependencyProxyResolver {
  late DependencyResolver? resolver;

  T resolve<T>() => resolver!.resolve<T>();
  T? maybeResolve<T>() => resolver!.maybeResolve<T>();
}
