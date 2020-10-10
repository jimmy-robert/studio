import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart' as mobx;

class Rx extends StatelessWidget {
  final WidgetBuilder builder;

  const Rx.builder({
    Key key,
    @required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Observer(builder: builder);

  static Observable<T> observable<T>(T value) => _Observable<T>(mobx.Observable<T>(value));

  static Computed<T> computed<T>(T Function() compute) => _Computed<T>(mobx.Computed<T>(compute));

  static T run<T>(T Function() action) => mobx.Action(action, name: 'Action')() as T;

  static Future<T> runAsync<T>(Future<T> Function() action) => mobx.AsyncAction('AsyncAction').run<T>(action);
}

abstract class Observable<T> {
  T get value;
  set value(T value);

  const Observable._();
}

abstract class Computed<T> {
  T get value;

  const Computed._();
}

class _Observable<T> extends Observable<T> {
  final mobx.Observable<T> source;

  @override
  T get value => source.value;

  @override
  set value(T value) => source.value = value;

  const _Observable(this.source) : super._();
}

class _Computed<T> extends Computed<T> {
  final mobx.Computed<T> source;

  @override
  T get value => source.value;

  const _Computed(this.source) : super._();
}
