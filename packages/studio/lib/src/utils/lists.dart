import 'package:studio/src/types/value_predicate.dart';

extension StudioListExtensions<T> on List<T> {
  void removeLastWhere(ValuePredicate<T> predicate) {
    final index = lastIndexWhere(predicate);
    if (index > -1) removeAt(index);
  }

  void replaceWhere(T value, ValuePredicate<T> predicate) {
    final index = indexWhere(predicate);
    if (index > -1) this[index] = value;
  }

  void replaceLastWhere(T value, ValuePredicate<T> predicate) {
    final index = lastIndexWhere(predicate);
    if (index > -1) this[index] = value;
  }

  void insertBeforeWhere(T value, ValuePredicate<T> predicate) {
    final index = indexWhere(predicate);
    if (index > -1) insert(index, value);
  }

  void insertAfterWhere(T value, ValuePredicate<T> predicate) {
    final index = indexWhere(predicate);
    if (index > -1) insert(index + 1, value);
  }

  void insertBeforeLastWhere(T value, ValuePredicate<T> predicate) {
    final index = lastIndexWhere(predicate);
    if (index > -1) insert(index, value);
  }

  void insertAfterLastWhere(T value, ValuePredicate<T> predicate) {
    final index = lastIndexWhere(predicate);
    if (index > -1) insert(index + 1, value);
  }
}
