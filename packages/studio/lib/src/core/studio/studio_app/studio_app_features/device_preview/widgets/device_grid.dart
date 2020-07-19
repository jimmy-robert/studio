import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart' hide runInAction;

import '../../../../../provider/provider.dart';
import '../../../../../reactive/actions.dart';
import '../../../../../reactive/observer.dart';
import '../data/devices/ipads.dart';
import '../data/devices/iphones.dart';
import '../data/devices/pixels.dart';
import 'device_grid_item.dart';

class DeviceGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<_DeviceGridController>(
      () => _DeviceGridController(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Select device'),
        ),
        body: CustomScrollView(
          slivers: [
            Builder(
              builder: (context) {
                final controller = context.get<_DeviceGridController>();
                return SliverPersistentHeader(
                  floating: true,
                  delegate: _SearchFilterDelegate(onTextChanged: controller.search),
                );
              },
            ),
            Observer(
              builder: (context) {
                final controller = context.get<_DeviceGridController>();
                final devices = controller.devices.value;
                return SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return DeviceGridItem(device: devices[index]);
                    },
                    childCount: devices.length,
                  ),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 220,
                    childAspectRatio: 1 / 2,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _DeviceGridController {
  final devices = Observable(_suggestions);

  final searchController = TextEditingController();

  void search(String value) {
    runInAction(() {
      if (value.isEmpty) {
        devices.value = _suggestions;
      } else {
        devices.value = _allDevices.where((device) {
          return device.name.toLowerCase().contains(value.toLowerCase());
        }).toList();
      }
    });
  }
}

final _suggestions = [
  ApplePhones.iPhone11,
  ApplePhones.iPhone11Pro,
  ApplePhones.iPhoneSEGen2,
  AppleTablets.iPadPro11,
  AppleTablets.iPadPro12_9Gen3,
  GooglePhones.pixel,
  GooglePhones.pixelXl,
];

final _allDevices = [
  ApplePhones.iPhone,
  ApplePhones.iPhone3G,
  ApplePhones.iPhone3Gs,
  ApplePhones.iPhone4,
  ApplePhones.iPhone4s,
  ApplePhones.iPhone5,
  ApplePhones.iPhone5s,
  ApplePhones.iPhone5c,
  ApplePhones.iPhone6,
  ApplePhones.iPhone6Plus,
  ApplePhones.iPhoneSE,
  ApplePhones.iPhone6s,
  ApplePhones.iPhone6sPlus,
  ApplePhones.iPhone7,
  ApplePhones.iPhone7Plus,
  ApplePhones.iPhone8,
  ApplePhones.iPhone8Plus,
  ApplePhones.iPhoneX,
  ApplePhones.iPhoneXs,
  ApplePhones.iPhoneXsMax,
  ApplePhones.iPhoneXr,
  ApplePhones.iPhone11,
  ApplePhones.iPhone11Pro,
  ApplePhones.iPhone11ProMax,
  ApplePhones.iPhoneSEGen2,
  AppleTablets.iPad,
  AppleTablets.iPad2,
  AppleTablets.iPad3,
  AppleTablets.iPad4,
  AppleTablets.iPadMini,
  AppleTablets.iPadMini2,
  AppleTablets.iPadMini3,
  AppleTablets.iPadMini4,
  AppleTablets.iPadAir,
  AppleTablets.iPadAir2,
  AppleTablets.iPadAir3,
  AppleTablets.iPadPro9_7,
  AppleTablets.iPadPro10_5,
  AppleTablets.iPadPro12_9,
  AppleTablets.iPadPro11,
  AppleTablets.iPadPro12_9Gen3,
  GooglePhones.nexus4,
  GooglePhones.nexus5,
  GooglePhones.nexus6,
  GooglePhones.nexus5x,
  GooglePhones.pixel,
  GooglePhones.pixelXl,
];

class _SearchFilterDelegate extends SliverPersistentHeaderDelegate {
  final void Function(String value) onTextChanged;

  const _SearchFilterDelegate({@required this.onTextChanged});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Card(
      margin: const EdgeInsets.all(12),
      color: Color(0xFF191E25),
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(width: 8),
            Icon(Icons.search, color: Color(0xFF9AA0A6)),
            SizedBox(width: 16),
            Expanded(
              child: Container(
                child: TextField(
                  cursorColor: Colors.grey,
                  onChanged: onTextChanged,
                  enableInteractiveSelection: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(bottom: 4),
                    hintText: 'Search device',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  final double maxExtent = 72;

  @override
  final double minExtent = 72;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
