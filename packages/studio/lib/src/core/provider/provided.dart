import 'resolver.dart';

mixin Provided {
  Resolver resolver;

  T get<T extends Provided>({bool allowNull = true}) {
    assert(resolver != null);
    return resolver.resolve<T>(allowNull: allowNull);
  }

  void onCreate() {}

  void onDispose() {}
}
