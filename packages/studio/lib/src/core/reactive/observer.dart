import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart' as flutter_mobx;

class Observer extends StatelessWidget {
  final WidgetBuilder builder;

  const Observer({@required this.builder});

  @override
  Widget build(BuildContext context) {
    return flutter_mobx.Observer(builder: builder);
  }
}
