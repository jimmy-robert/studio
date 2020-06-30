import 'package:mobx/mobx.dart';

Future<T> runInAsyncAction<T>(Future<T> Function() callback, {String name = ''}) {
  return AsyncAction(name).run<T>(callback);
}
