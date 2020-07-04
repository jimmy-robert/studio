import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/material.dart';

import '../utils/duration.dart';

class RerunWidget extends StatefulWidget {
  final Widget child;

  const RerunWidget({Key key, @required this.child}) : super(key: key);

  @override
  RerunWidgetState createState() => RerunWidgetState();
}

class RerunWidgetState extends State<RerunWidget> with TickerProviderStateMixin {
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
        child: widget.child,
      ),
    );
  }

  Future<void> rerun() async {
    final duration = 100.milliseconds;

    await _circularRevealController.reverse();

    setState(() {
      _empty = true;
    });
    await Future<void>.delayed(duration);

    setState(() {
      _empty = false;
    });
    await Future<void>.delayed(duration);

    await _circularRevealController.forward();
  }
}
