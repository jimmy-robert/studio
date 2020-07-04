import 'package:flutter/material.dart';

class StudioTrojan extends StatefulWidget {
  final Widget child;

  const StudioTrojan({Key key, @required this.child}) : super(key: key);

  @override
  StudioTrojanState createState() => StudioTrojanState();
}

class StudioTrojanState extends State<StudioTrojan> {
  @override
  Widget build(BuildContext context) => widget.child;
}
