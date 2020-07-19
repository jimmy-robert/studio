import 'package:studio/src/core/studio/studio_app/studio_app_features/device_preview/data/device_side_button.dart';
import 'package:studio/studio.dart';

class DeviceBody {
  static const EdgeInsets defaultInsets = EdgeInsets.all(8);
  static const Color defaultColor = Color(0xFF1A1A1A);
  static const Radius defaultEdgeRadius = Radius.circular(8);
  static const Radius defaultScreenRadius = Radius.circular(4);
  static const Color defaultBorderColor = Colors.grey;
  static const double defaultBorderSize = 1;

  final EdgeInsets insets;
  final Color color;
  final Radius edgeRadius;
  final Radius screenRadius;
  final Color borderColor;
  final double borderSize;
  final List<DeviceSideButton> sideButtons;

  const DeviceBody({
    this.insets = defaultInsets,
    this.color = defaultColor,
    this.edgeRadius = defaultEdgeRadius,
    this.screenRadius = defaultScreenRadius,
    this.borderColor = defaultBorderColor,
    this.borderSize = defaultBorderSize,
    this.sideButtons = const [],
  });

  DeviceBody copyWith({
    EdgeInsets insets,
    Color color,
    Radius edgeRadius,
    Radius screenRadius,
    Color borderColor,
    double borderSize,
    List<DeviceSideButton> sideButtons,
  }) {
    return DeviceBody(
      insets: insets ?? this.insets,
      color: color ?? this.color,
      edgeRadius: edgeRadius ?? this.edgeRadius,
      screenRadius: screenRadius ?? this.screenRadius,
      borderColor: borderColor ?? this.borderColor,
      borderSize: borderSize ?? this.borderSize,
      sideButtons: sideButtons ?? this.sideButtons,
    );
  }

  DeviceBody remove({
    bool insets = false,
    bool color = false,
    bool edgeRadius = false,
    bool screenRadius = false,
    bool borderColor = false,
    bool borderSize = false,
    bool sideButtons = false,
  }) {
    return DeviceBody(
      insets: insets ? null : this.insets,
      color: color ? null : this.color,
      edgeRadius: edgeRadius ? null : this.edgeRadius,
      screenRadius: screenRadius ? null : this.screenRadius,
      borderColor: borderColor ? null : this.borderColor,
      borderSize: borderSize ? null : this.borderSize,
      sideButtons: sideButtons ? null : this.sideButtons,
    );
  }
}
