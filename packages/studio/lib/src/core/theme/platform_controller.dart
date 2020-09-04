import 'package:flutter/foundation.dart';

import '../reactive/rx.dart';

class PlatformController {
  final platform = Rx.observable<TargetPlatform>(null);
}
