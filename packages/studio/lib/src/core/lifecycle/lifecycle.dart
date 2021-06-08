import 'package:flutter/material.dart';

mixin Lifecycle {
  @mustCallSuper
  void onCreate() {}

  @mustCallSuper
  void onDestroy() {}
}
