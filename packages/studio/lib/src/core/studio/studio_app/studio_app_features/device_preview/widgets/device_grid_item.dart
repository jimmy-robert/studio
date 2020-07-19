import 'package:flutter/material.dart';

import '../../../../../provider/provider.dart';
import '../../../../../reactive/actions.dart';
import '../data/device.dart';
import '../device_preview_controller.dart';
import 'device_frame.dart';

class DeviceGridItem extends StatelessWidget {
  final Device device;

  const DeviceGridItem({@required this.device});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        DeviceFrame(
          device: device,
          child: Material(
            color: Colors.grey.shade700,
            child: GestureDetector(
              onTap: () {},
              child: InkWell(
                hoverColor: Colors.blueAccent.withOpacity(0.75),
                onTap: () {
                  runInAction(() {
                    final controller = context.get<DevicePreviewController>();
                    controller.device.value = device;
                  });
                },
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: IgnorePointer(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26),
              child: Center(
                child: FittedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        device.name,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '${device.size.width.round()} x ${device.size.height.round()}',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white60,
                        ),
                      ),
                      Text(
                        '@${device.devicePixelRatio % 1 == 0 ? device.devicePixelRatio.round() : device.devicePixelRatio}x',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white60,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
