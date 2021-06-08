import 'dart:async';

import 'package:rxdart/rxdart.dart';

abstract class Observable<T> {
  Stream<T> get stream;
}

class Value<T> extends Observable<T> {
  @override
  Stream<T> get stream => _subject.stream;

  final BehaviorSubject<T> _subject;

  T get value => _subject.value;

  set value(T value) {
    if (_subject.value == value) return;
    _subject.value = value;
  }

  Value(T value) : _subject = BehaviorSubject<T>.seeded(value);

  void forceValue(T value) => _subject.value = value;
}

class Combo extends Observable<List<dynamic>> {
  @override
  final Stream<List<dynamic>> stream;

  Combo(List<Observable> list) : stream = _combine(list);

  static Stream<List<dynamic>> _combine(List<Observable> list) {
    final streams = list.map((observable) => observable.stream);
    return Rx.combineLatestList<dynamic>(streams).asBroadcastStream();
  }
}
