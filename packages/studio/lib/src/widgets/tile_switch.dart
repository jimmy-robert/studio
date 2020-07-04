import 'package:flutter/material.dart';

class TileSwitch extends StatelessWidget {
  final bool value;
  final void Function(bool value) onChanged;

  const TileSwitch({@required this.value, @required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      excludeFromSemantics: true,
      canRequestFocus: false,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      onTap: () {},
      child: Switch(
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
