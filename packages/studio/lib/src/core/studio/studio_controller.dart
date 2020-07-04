import 'package:mobx/mobx.dart';

import '../../utils/duration.dart';

class StudioController {
  final _selectedIndex = Observable(0);
  int get selectedIndex => _selectedIndex.value;
  set selectedIndex(int value) => runInAction(() => _selectedIndex.value = value);

  final _appMenuWidth = Observable(400.0);
  double get appMenuWidth => _appMenuWidth.value;
  set appMenuWidth(double value) => _appMenuWidth.value = value;

  final _appMenuOpen = Observable(true);
  bool get appMenuOpen => _appMenuOpen.value;
  set appMenuOpen(bool value) => _appMenuOpen.value = value;

  final _animationDuration = Observable(200.milliseconds);
  Duration get animationDuration => _animationDuration.value;
  set animationDuration(Duration value) => _animationDuration.value = value;

  double appMenuDraggingWidth = 400;
}
