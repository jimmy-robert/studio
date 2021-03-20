import 'package:flutter/material.dart';

class InitWidget extends StatefulWidget {
  final void Function(BuildContext context) onInit;
  final Widget child;

  const InitWidget({
    Key key,
    @required this.onInit,
    @required this.child,
  }) : super(key: key);

  @override
  _OnInitWidgetState createState() => _OnInitWidgetState();
}

class _OnInitWidgetState extends State<InitWidget> {
  @override
  void initState() {
    super.initState();
    widget.onInit(context);
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
