import 'package:flutter/material.dart';
import 'package:studio/src/core/studio/studio_app/studio_app_features/device_preview/data/device_body.dart';
import 'package:studio/src/core/studio/studio_app/studio_app_features/device_preview/data/device_side_button.dart';
import 'package:studio/src/core/studio/studio_app/studio_app_features/device_preview/device_preview_controller.dart';
import 'package:studio/src/core/studio/studio_app/studio_app_features/device_preview/widgets/device_color_editor.dart';
import 'package:studio/src/core/studio/studio_app/studio_app_features/device_preview/widgets/device_value_editor.dart';
import 'package:studio/studio.dart';

import '../../../../../../widgets/separated_list.dart';

class DeviceSideButtonScreen extends StatelessWidget {
  final int index;

  const DeviceSideButtonScreen({@required this.index});

  @override
  Widget build(BuildContext context) {
    final controller = context.get<DevicePreviewController>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Side button'),
      ),
      body: Observer(
        builder: (context) {
          final device = controller.device.value;
          final button = device.body.sideButtons[index];
          return SeparatedList(
            children: [
              ListTile(
                title: Text('Edge'),
                subtitle: Text(button.edge.toString()),
              ),
              ListTile(
                title: Text('Align'),
                subtitle: Text(button.align.toString()),
              ),
              DeviceColorEditor(
                title: 'Color',
                color: button.color,
                onColorChanged: (color) {
                  runInAction(() {
                    controller.device.value = device.copyWith(
                      body: DeviceBody(
                        insets: device.body.insets,
                        color: device.body.color,
                        edgeRadius: device.body.edgeRadius,
                        screenRadius: device.body.screenRadius,
                        borderColor: device.body.borderColor,
                        borderSize: device.body.borderSize,
                        sideButtons: [...device.body.sideButtons]
                          ..removeAt(index)
                          ..insert(
                            index,
                            DeviceSideButton(
                              align: button.align,
                              color: color,
                              edge: button.edge,
                              offset: button.offset,
                              radius: button.radius,
                              size: button.size,
                            ),
                          ),
                      ),
                    );
                  });
                },
              ),
              Container(
                height: 24,
                color: Colors.white.withOpacity(0.015),
              ),
              Container(
                color: Colors.black12,
                child: ListTile(
                  title: Text('Size'),
                ),
              ),
              DeviceValueEditor(
                title: 'Width',
                value: button.size.width,
                minValue: 0,
                maxValue: 400,
                onValueChanged: (value) {
                  runInAction(() {
                    controller.device.value = device.copyWith(
                      body: DeviceBody(
                        insets: device.body.insets,
                        color: device.body.color,
                        edgeRadius: device.body.edgeRadius,
                        screenRadius: device.body.screenRadius,
                        borderColor: device.body.borderColor,
                        borderSize: device.body.borderSize,
                        sideButtons: [...device.body.sideButtons]
                          ..removeAt(index)
                          ..insert(
                            index,
                            DeviceSideButton(
                              align: button.align,
                              color: button.color,
                              edge: button.edge,
                              offset: button.offset,
                              radius: button.radius,
                              size: Size(value, button.size.height),
                            ),
                          ),
                      ),
                    );
                  });
                },
              ),
              DeviceValueEditor(
                title: 'Height',
                value: button.size.height,
                minValue: 0,
                maxValue: 16,
                onValueChanged: (value) {
                  runInAction(() {
                    controller.device.value = device.copyWith(
                      body: DeviceBody(
                        insets: device.body.insets,
                        color: device.body.color,
                        edgeRadius: device.body.edgeRadius,
                        screenRadius: device.body.screenRadius,
                        borderColor: device.body.borderColor,
                        borderSize: device.body.borderSize,
                        sideButtons: [...device.body.sideButtons]
                          ..removeAt(index)
                          ..insert(
                            index,
                            DeviceSideButton(
                              align: button.align,
                              color: button.color,
                              edge: button.edge,
                              offset: button.offset,
                              radius: button.radius,
                              size: Size(button.size.width, value),
                            ),
                          ),
                      ),
                    );
                  });
                },
              ),
              Container(
                height: 24,
                color: Colors.white.withOpacity(0.015),
              ),
              Container(
                color: Colors.black12,
                child: ListTile(
                  title: Text('Radius'),
                ),
              ),
              DeviceValueEditor(
                title: 'x',
                value: button.radius.x,
                minValue: 0,
                maxValue: 16,
                onValueChanged: (value) {
                  runInAction(() {
                    controller.device.value = device.copyWith(
                      body: DeviceBody(
                        insets: device.body.insets,
                        color: device.body.color,
                        edgeRadius: device.body.edgeRadius,
                        screenRadius: device.body.screenRadius,
                        borderColor: device.body.borderColor,
                        borderSize: device.body.borderSize,
                        sideButtons: [...device.body.sideButtons]
                          ..removeAt(index)
                          ..insert(
                            index,
                            DeviceSideButton(
                              align: button.align,
                              color: button.color,
                              edge: button.edge,
                              offset: button.offset,
                              radius: Radius.elliptical(value, button.radius.y),
                              size: button.size,
                            ),
                          ),
                      ),
                    );
                  });
                },
              ),
              DeviceValueEditor(
                title: 'y',
                value: button.radius.y,
                minValue: 0,
                maxValue: 16,
                onValueChanged: (value) {
                  runInAction(() {
                    controller.device.value = device.copyWith(
                      body: DeviceBody(
                        insets: device.body.insets,
                        color: device.body.color,
                        edgeRadius: device.body.edgeRadius,
                        screenRadius: device.body.screenRadius,
                        borderColor: device.body.borderColor,
                        borderSize: device.body.borderSize,
                        sideButtons: [...device.body.sideButtons]
                          ..removeAt(index)
                          ..insert(
                            index,
                            DeviceSideButton(
                              align: button.align,
                              color: button.color,
                              edge: button.edge,
                              offset: button.offset,
                              radius: Radius.elliptical(button.radius.x, value),
                              size: button.size,
                            ),
                          ),
                      ),
                    );
                  });
                },
              ),
              Container(
                height: 24,
                color: Colors.white.withOpacity(0.015),
              ),
              Container(
                color: Colors.black12,
                child: ListTile(
                  title: Text('Offset'),
                ),
              ),
              DeviceValueEditor(
                title: 'dx',
                value: button.offset.dx,
                minValue: 0,
                maxValue: 1400,
                onValueChanged: (value) {
                  runInAction(() {
                    controller.device.value = device.copyWith(
                      body: DeviceBody(
                        insets: device.body.insets,
                        color: device.body.color,
                        edgeRadius: device.body.edgeRadius,
                        screenRadius: device.body.screenRadius,
                        borderColor: device.body.borderColor,
                        borderSize: device.body.borderSize,
                        sideButtons: [...device.body.sideButtons]
                          ..removeAt(index)
                          ..insert(
                            index,
                            DeviceSideButton(
                              align: button.align,
                              color: button.color,
                              edge: button.edge,
                              offset: Offset(value, button.offset.dy),
                              radius: button.radius,
                              size: button.size,
                            ),
                          ),
                      ),
                    );
                  });
                },
              ),
              DeviceValueEditor(
                title: 'dy',
                value: button.offset.dy,
                minValue: 0,
                maxValue: 1400,
                onValueChanged: (value) {
                  runInAction(() {
                    controller.device.value = device.copyWith(
                      body: DeviceBody(
                        insets: device.body.insets,
                        color: device.body.color,
                        edgeRadius: device.body.edgeRadius,
                        screenRadius: device.body.screenRadius,
                        borderColor: device.body.borderColor,
                        borderSize: device.body.borderSize,
                        sideButtons: [...device.body.sideButtons]
                          ..removeAt(index)
                          ..insert(
                            index,
                            DeviceSideButton(
                              align: button.align,
                              color: button.color,
                              edge: button.edge,
                              offset: Offset(button.offset.dx, value),
                              radius: button.radius,
                              size: button.size,
                            ),
                          ),
                      ),
                    );
                  });
                },
              ),
              Container(
                height: 24,
                color: Colors.white.withOpacity(0.015),
              ),
            ],
          );
        },
      ),
    );
  }
}
