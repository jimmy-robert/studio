import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/material.dart';

class RestartWidget extends StatefulWidget {
  final Widget child;

  const RestartWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  RestartWidgetState createState() => RestartWidgetState();
}

class RestartWidgetState extends State<RestartWidget> with TickerProviderStateMixin {
  late final _animationController = AnimationController(
    value: 1,
    duration: const Duration(milliseconds: 200),
    vsync: this,
  );

  var _empty = false;

  @override
  Widget build(BuildContext context) {
    if (_empty) return Container(color: Colors.black);

    return Container(
      color: Colors.black,
      child: CircularRevealAnimation(
        animation: _animationController,
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  Future<void> restart() async {
    const duration = Duration(milliseconds: 100);
    await _animationController.reverse();
    setState(() => _empty = true);
    await Future<void>.delayed(duration);
    setState(() => _empty = false);
    await Future<void>.delayed(duration);
    await _animationController.forward();
  }
}
