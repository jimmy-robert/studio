import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

class ThemeModeController {
  final mode = Observable(ThemeMode.system);
}
