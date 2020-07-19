import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:studio/src/core/studio/studio_app/studio_app_features/device_preview/data/device_edge.dart';
import 'package:studio/src/core/studio/studio_app/studio_app_features/device_preview/data/device_side_button.dart';
import 'package:studio/src/core/studio/studio_app/studio_app_features/device_preview/widgets/device_side_button_screen.dart';
import 'package:studio/src/utils/navigator.dart';

import '../../../../../../../studio.dart';
import '../../../../../../widgets/separated_list.dart';
import '../../../../../reactive/observer.dart';
import '../data/device_body.dart';
import '../device_preview_controller.dart';
import 'device_color_editor.dart';
import 'device_value_editor.dart';

class DeviceBodyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Body'),
      ),
      body: Observer(
        builder: (context) {
          final controller = context.get<DevicePreviewController>();
          final device = controller.device.value;
          return SeparatedList(
            children: [
              Container(
                height: 24,
                color: Colors.white.withOpacity(0.015),
              ),
              Container(
                color: Colors.black12,
                child: ListTile(
                  title: Text('Insets'),
                ),
              ),
              DeviceValueEditor(
                title: 'Left',
                value: device.body.insets.left,
                minValue: 0,
                maxValue: 200,
                onValueChanged: (value) {
                  runInAction(() {
                    controller.device.value = device.copyWith(
                      body: DeviceBody(
                        sideButtons: device.body.sideButtons,
                        borderSize: device.body.borderSize,
                        borderColor: device.body.borderColor,
                        insets: EdgeInsets.only(
                          left: value,
                          top: device.body.insets.top,
                          right: device.body.insets.right,
                          bottom: device.body.insets.bottom,
                        ),
                        edgeRadius: device.body.edgeRadius,
                        screenRadius: device.body.screenRadius,
                        color: device.body.color,
                      ),
                    );
                  });
                },
              ),
              DeviceValueEditor(
                title: 'Top',
                value: device.body.insets.top,
                minValue: 0,
                maxValue: 200,
                onValueChanged: (value) {
                  runInAction(() {
                    controller.device.value = device.copyWith(
                      body: DeviceBody(
                        sideButtons: device.body.sideButtons,
                        borderSize: device.body.borderSize,
                        borderColor: device.body.borderColor,
                        insets: EdgeInsets.only(
                          left: device.body.insets.left,
                          top: value,
                          right: device.body.insets.right,
                          bottom: device.body.insets.bottom,
                        ),
                        edgeRadius: device.body.edgeRadius,
                        screenRadius: device.body.screenRadius,
                        color: device.body.color,
                      ),
                    );
                  });
                },
              ),
              DeviceValueEditor(
                title: 'Right',
                value: device.body.insets.right,
                minValue: 0,
                maxValue: 200,
                onValueChanged: (value) {
                  runInAction(() {
                    controller.device.value = device.copyWith(
                      body: DeviceBody(
                        sideButtons: device.body.sideButtons,
                        borderSize: device.body.borderSize,
                        borderColor: device.body.borderColor,
                        insets: EdgeInsets.only(
                          left: device.body.insets.left,
                          top: device.body.insets.top,
                          right: value,
                          bottom: device.body.insets.bottom,
                        ),
                        edgeRadius: device.body.edgeRadius,
                        screenRadius: device.body.screenRadius,
                        color: device.body.color,
                      ),
                    );
                  });
                },
              ),
              DeviceValueEditor(
                title: 'Bottom',
                value: device.body.insets.bottom,
                minValue: 0,
                maxValue: 200,
                onValueChanged: (value) {
                  runInAction(() {
                    controller.device.value = device.copyWith(
                      body: DeviceBody(
                        sideButtons: device.body.sideButtons,
                        borderSize: device.body.borderSize,
                        borderColor: device.body.borderColor,
                        insets: EdgeInsets.only(
                          left: device.body.insets.left,
                          top: device.body.insets.top,
                          right: device.body.insets.right,
                          bottom: value,
                        ),
                        edgeRadius: device.body.edgeRadius,
                        screenRadius: device.body.screenRadius,
                        color: device.body.color,
                      ),
                    );
                  });
                },
              ),
              Container(
                height: 24,
                color: Colors.white.withOpacity(0.015),
              ),
              DeviceColorEditor(
                title: 'Color',
                color: device.body.color,
                onColorChanged: (color) {
                  runInAction(() {
                    controller.device.value = device.copyWith(
                      body: DeviceBody(
                        sideButtons: device.body.sideButtons,
                        borderSize: device.body.borderSize,
                        borderColor: device.body.borderColor,
                        insets: device.body.insets,
                        edgeRadius: device.body.edgeRadius,
                        screenRadius: device.body.screenRadius,
                        color: color,
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
                  title: Text('Edge radius'),
                ),
              ),
              DeviceValueEditor(
                title: 'x',
                value: device.body.edgeRadius.x,
                minValue: 0,
                maxValue: 300,
                onValueChanged: (value) {
                  runInAction(() {
                    controller.device.value = device.copyWith(
                      body: DeviceBody(
                        sideButtons: device.body.sideButtons,
                        borderSize: device.body.borderSize,
                        borderColor: device.body.borderColor,
                        insets: device.body.insets,
                        edgeRadius: Radius.elliptical(value, device.body.edgeRadius.y),
                        screenRadius: device.body.screenRadius,
                        color: device.body.color,
                      ),
                    );
                  });
                },
              ),
              DeviceValueEditor(
                title: 'y',
                value: device.body.edgeRadius.y,
                minValue: 0,
                maxValue: 300,
                onValueChanged: (value) {
                  runInAction(() {
                    controller.device.value = device.copyWith(
                      body: DeviceBody(
                        sideButtons: device.body.sideButtons,
                        borderSize: device.body.borderSize,
                        borderColor: device.body.borderColor,
                        insets: device.body.insets,
                        edgeRadius: Radius.elliptical(device.body.edgeRadius.x, value),
                        screenRadius: device.body.screenRadius,
                        color: device.body.color,
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
                  title: Text('Screen radius'),
                ),
              ),
              DeviceValueEditor(
                title: 'x',
                value: device.body.screenRadius.x,
                minValue: 0,
                maxValue: 300,
                onValueChanged: (value) {
                  runInAction(() {
                    controller.device.value = device.copyWith(
                      body: DeviceBody(
                        sideButtons: device.body.sideButtons,
                        borderSize: device.body.borderSize,
                        borderColor: device.body.borderColor,
                        insets: device.body.insets,
                        edgeRadius: device.body.edgeRadius,
                        screenRadius: Radius.elliptical(value, device.body.screenRadius.y),
                        color: device.body.color,
                      ),
                    );
                  });
                },
              ),
              DeviceValueEditor(
                title: 'y',
                value: device.body.screenRadius.y,
                minValue: 0,
                maxValue: 300,
                onValueChanged: (value) {
                  runInAction(() {
                    controller.device.value = device.copyWith(
                      body: DeviceBody(
                        sideButtons: device.body.sideButtons,
                        borderSize: device.body.borderSize,
                        borderColor: device.body.borderColor,
                        insets: device.body.insets,
                        edgeRadius: device.body.edgeRadius,
                        screenRadius: Radius.elliptical(device.body.screenRadius.x, value),
                        color: device.body.color,
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
                  title: Text('Border'),
                ),
              ),
              DeviceValueEditor(
                title: 'Size',
                value: device.body.borderSize,
                minValue: 0,
                maxValue: 16,
                onValueChanged: (value) {
                  runInAction(() {
                    controller.device.value = device.copyWith(
                      body: DeviceBody(
                        sideButtons: device.body.sideButtons,
                        borderSize: value,
                        borderColor: device.body.borderColor,
                        insets: device.body.insets,
                        edgeRadius: device.body.edgeRadius,
                        screenRadius: device.body.screenRadius,
                        color: device.body.color,
                      ),
                    );
                  });
                },
              ),
              DeviceColorEditor(
                title: 'Color',
                color: device.body.borderColor,
                onColorChanged: (color) {
                  runInAction(() {
                    controller.device.value = device.copyWith(
                      body: DeviceBody(
                        sideButtons: device.body.sideButtons,
                        borderSize: device.body.borderSize,
                        borderColor: color,
                        insets: device.body.insets,
                        edgeRadius: device.body.edgeRadius,
                        screenRadius: device.body.screenRadius,
                        color: device.body.color,
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
                  title: Text('Side buttons'),
                  trailing: IconButton(
                    icon: Icon(MdiIcons.plus),
                    splashRadius: 24,
                    iconSize: 24,
                    onPressed: () {
                      runInAction(() {
                        controller.device.value = device.copyWith(
                          body: DeviceBody(
                            sideButtons: [...device.body.sideButtons, DeviceSideButton()],
                            borderSize: device.body.borderSize,
                            borderColor: device.body.borderColor,
                            insets: device.body.insets,
                            edgeRadius: device.body.edgeRadius,
                            screenRadius: device.body.screenRadius,
                            color: device.body.color,
                          ),
                        );
                      });
                    },
                  ),
                ),
              ),
              ...device.body.sideButtons.map((button) {
                return ListTile(
                  title: Text('${button.edge.name} button'),
                  trailing: IconButton(
                    icon: Icon(MdiIcons.delete),
                    splashRadius: 24,
                    iconSize: 24,
                    onPressed: () {
                      final index = device.body.sideButtons.indexOf(button);
                      runInAction(() {
                        controller.device.value = device.copyWith(
                          body: DeviceBody(
                            sideButtons: [...device.body.sideButtons]..removeAt(index),
                            borderSize: device.body.borderSize,
                            borderColor: device.body.borderColor,
                            insets: device.body.insets,
                            edgeRadius: device.body.edgeRadius,
                            screenRadius: device.body.screenRadius,
                            color: device.body.color,
                          ),
                        );
                      });
                    },
                  ),
                  onTap: () {
                    Navigator.of(context).pushWidget<void>(builder: (context) {
                      return DeviceSideButtonScreen(index: device.body.sideButtons.indexOf(button));
                    });
                  },
                );
              }),
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

extension on DeviceEdge {
  String get name {
    switch (this) {
      case DeviceEdge.top:
        return 'Top';
      case DeviceEdge.left:
        return 'Left';
      case DeviceEdge.right:
        return 'Right';
      case DeviceEdge.bottom:
        return 'Bottom';
      default:
        return null;
    }
  }
}
