import 'package:mobx/mobx.dart';

T runInAction<T>(T Function() callback) {
  return Action(callback, name: 'Action')() as T;
}

Future<T> runInAsyncAction<T>(Future<T> Function() callback) {
  return AsyncAction('AsyncAction').run<T>(callback);
}
