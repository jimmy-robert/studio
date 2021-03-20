import 'resolver.dart';

mixin Injection {
  Resolver resolver;
  T resolve<T>({bool allowNull = true}) => resolver.resolve<T>(allowNull: allowNull);

  void onCreate() {}
  void onDispose() {}
}
