import 'package:flutter/material.dart';

import '../reactive/rx.dart';

class ThemeController {
  final mode = Rx.observable(ThemeMode.system);
  final light = Rx.observable(ThemeData.fallback());
  final dark = Rx.observable<ThemeData>(null);
}
