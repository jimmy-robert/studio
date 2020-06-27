import 'provided.dart';

abstract class Resolver {
  T resolve<T extends Provided>({bool allowNull = true});
}
