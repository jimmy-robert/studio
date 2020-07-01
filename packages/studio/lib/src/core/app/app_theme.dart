import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

class AppTheme {
  final light = Observable<ThemeData>(ThemeData.light());

  final dark = Observable<ThemeData>(ThemeData.dark());

  final mode = Observable<ThemeMode>(ThemeMode.system);
}
