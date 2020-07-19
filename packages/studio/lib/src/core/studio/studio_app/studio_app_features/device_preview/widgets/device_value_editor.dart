import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../../../utils/number.dart';

class DeviceValueEditor extends StatelessWidget {
  final bool enabled;
  final IconData icon;
  final String title;
  final double value;
  final double minValue;
  final double maxValue;
  final void Function(double value) onValueChanged;

  const DeviceValueEditor({
    @required this.title,
    @required this.value,
    @required this.minValue,
    @required this.maxValue,
    @required this.onValueChanged,
    this.enabled = true,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          enabled: enabled,
          leading: icon != null ? Icon(icon) : null,
          title: Text(title),
          trailing: Transform(
            transform: Matrix4.translationValues(8, 0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(MdiIcons.minus),
                  splashRadius: 16,
                  onPressed: enabled && value > minValue ? () => onValueChanged(value - 1) : null,
                  iconSize: 16,
                ),
                SizedBox(
                  width: 36,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Center(
                      child: Text(
                        '${value.short}',
                        style: TextStyle(
                          color: enabled //
                              ? Theme.of(context).textTheme.caption.color
                              : Theme.of(context).disabledColor,
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(MdiIcons.plus),
                  splashRadius: 16,
                  iconSize: 16,
                  onPressed: enabled && value < maxValue ? () => onValueChanged(value + 1) : null,
                ),
              ],
            ),
          ),
        ),
        Transform(
          transform: Matrix4.translationValues(0, -8, 0),
          child: Slider(
            min: minValue,
            max: maxValue,
            value: value,
            onChanged: enabled ? (value) => onValueChanged(value.roundToDouble()) : null,
            divisions: (maxValue - minValue).round(),
          ),
        ),
      ],
    );
  }
}
