import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../widgets/value_selector.dart';

class TimeDilationTile extends StatefulWidget {
  @override
  _TimeDilationTileState createState() => _TimeDilationTileState();
}

class _TimeDilationTileState extends State<TimeDilationTile> {
  @override
  Widget build(BuildContext context) {
    final value = timeDilation % 1 == 0 ? timeDilation.round() : timeDilation;
    return ListTile(
      leading: Icon(MdiIcons.clockFast),
      title: Text('Time dilation'),
      subtitle: Text('${value}x'),
      onTap: () async {
        final route = MaterialPageRoute<double>(
          builder: (context) {
            return const ValueSelector<double>(
              title: 'Time dilation',
              items: [
                ValueSelectorItem('0.25x', 0.25),
                ValueSelectorItem('0.5x', 0.5),
                ValueSelectorItem('0.75x', 0.75),
                ValueSelectorItem('1x', 1),
                ValueSelectorItem('1.5x', 1.5),
                ValueSelectorItem('2x', 2),
                ValueSelectorItem('3x', 3),
                ValueSelectorItem('5x', 5),
                ValueSelectorItem('10x', 10),
              ],
            );
          },
        );
        final value = await Navigator.of(context).push(route);
        if (value != null) setState(() => timeDilation = value);
      },
    );
  }
}
