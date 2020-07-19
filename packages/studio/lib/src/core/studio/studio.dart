import 'package:flutter/material.dart';

import '../../widgets/rerun_widget.dart';
import '../app/app.dart';
import '../provider/module.dart';
import '../provider/provider.dart';
import 'studio_app/studio_app_bar.dart';
import 'studio_app/studio_app_features/bold_text.dart';
import 'studio_app/studio_app_features/brightness.dart';
import 'studio_app/studio_app_features/device_preview/device_preview_app_wrapper.dart';
import 'studio_app/studio_app_features/device_preview/device_preview_controller.dart';
import 'studio_app/studio_app_features/text_scale_factor.dart';
import 'studio_body.dart';
import 'studio_controller.dart';
import 'studio_trojan.dart';

mixin Studio on App {
  @override
  Widget wrapAppController(BuildContext context, Widget child) {
    child = super.wrapAppController(context, child);
    return RerunWidget(
      child: ModuleWidget(
        module: Module() //
          ..add(Provider(() => StudioController()))
          ..add(Provider(() => DevicePreviewController()))
          ..add(Provider(() => BrightnessController()))
          ..add(Provider(() => TextScaleFactorController()))
          ..add(Provider(() => BoldTextController())),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 56.0),
                child: StudioBody(app: child),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 56,
                child: StudioAppBar(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget wrapApp(BuildContext context, Widget child) {
    child = super.wrapApp(context, child);
    final controller = context.get<StudioController>();
    child = BrightnessWrapper(child: child);
    child = TextScaleFactorWrapper(child: child);
    child = BoldTextWrapper(child: child);
    child = DevicePreviewAppWrapper(child: child);
    return StudioTrojan(key: controller.trojanKey, child: child);
  }
}
