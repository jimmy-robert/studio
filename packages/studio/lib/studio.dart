import 'dart:async';

import 'package:flutter/services.dart';

class Studio {
  static const _channel = MethodChannel('studio');

  static Future<String?> get platformVersion async {
    return await _channel.invokeMethod<String>('getPlatformVersion');
  }
}
