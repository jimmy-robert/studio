import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/material.dart';

import '../../utils/duration.dart';
import '../provider/provider.dart';

mixin AppController {
  final navigatorKey = GlobalKey<NavigatorState>();

  void restart() {
    navigatorKey.currentState.pushNamedAndRemoveUntil('/', (route) => false);
  }

  void rerun();
}

class AppControllerWidget extends StatefulWidget {
  final Widget child;

  const AppControllerWidget({@required this.child});

  @override
  _AppControllerWidgetState createState() => _AppControllerWidgetState();
}

class _AppControllerWidgetState extends State<AppControllerWidget> with AppController, SingleTickerProviderStateMixin {
  var _session = DateTime.now();
  DateTime get session => _session;

  var _empty = false;

  AnimationController _circularRevealController;

  @override
  void initState() {
    super.initState();
    _circularRevealController = AnimationController(
      value: 1,
      vsync: this,
      duration: 250.milliseconds,
    );
  }

  @override
  void dispose() {
    _circularRevealController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_empty) return Container(color: Colors.black);

    return Container(
      color: Colors.black,
      child: CircularRevealAnimation(
        animation: _circularRevealController,
        child: Provider<AppController>.value(this, child: widget.child),
      ),
    );
  }

  @override
  void rerun() async {
    final duration = 100.milliseconds;

    await _circularRevealController.reverse();

    setState(() {
      _empty = true;
    });
    await Future<void>.delayed(duration);

    _session = DateTime.now();

    setState(() {
      _empty = false;
    });
    await Future<void>.delayed(duration);

    await _circularRevealController.forward();
  }
}
