import 'package:flutter/material.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:studio/src/core/provider/provider.dart';
import 'package:studio/src/core/reactive/observer.dart';
import 'package:studio/src/utils/navigator.dart';

class DeviceColorEditor extends StatelessWidget {
  final String title;
  final Color color;
  final void Function(Color color) onColorChanged;

  const DeviceColorEditor({
    @required this.title,
    @required this.color,
    @required this.onColorChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          enabled: color != null,
          leading: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white70),
              borderRadius: BorderRadius.circular(4),
              color: color,
            ),
          ),
          title: Text(title),
          subtitle: color != null ? Text('#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}') : Text('-'),
          onTap: () {
            Navigator.of(context).pushWidget<void>(builder: (context) {
              return _DeviceColorPicker(
                color: color,
                onColorChanged: onColorChanged,
              );
            });
          },
        ),
      ],
    );
  }
}

class _DeviceColorPickerController {
  final Observable<Color> color;
  final TextEditingController fieldController;

  _DeviceColorPickerController({Color color})
      : color = Observable(color),
        fieldController = TextEditingController(text: color.value.toRadixString(16).padLeft(8).toUpperCase());
}

class _DeviceColorPicker extends StatelessWidget {
  final Color color;
  final void Function(Color color) onColorChanged;

  const _DeviceColorPicker({
    @required this.color,
    @required this.onColorChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Color'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: Container()),
            Provider<_DeviceColorPickerController>(
              () => _DeviceColorPickerController(color: color),
              child: Observer(
                builder: (context) {
                  final controller = context.get<_DeviceColorPickerController>();
                  final color = controller.color.value;
                  return CircleColorPicker(
                    key: ValueKey(color),
                    colorCodeBuilder: (context, color) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('#'),
                          SizedBox(width: 8),
                          SizedBox(
                            width: 88,
                            child: TextFormField(
                              controller: controller.fieldController,
                              maxLength: 8,
                              maxLengthEnforced: true,
                              buildCounter: (BuildContext context, {currentLength, maxLength, isFocused}) => null,
                              cursorColor: Colors.grey,
                              onChanged: (value) {
                                if (value.length == 8) {
                                  final color = Color(int.parse(value, radix: 16));
                                  runInAction(() {
                                    controller.color.value = color;
                                  });
                                  onColorChanged(color);
                                }
                              },
                              enableInteractiveSelection: true,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    initialColor: color,
                    onChanged: (color) {
                      controller.fieldController.text = color.value.toRadixString(16).padLeft(8, '0').toUpperCase();
                      onColorChanged(color);
                    },
                  );
                },
              ),
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}
