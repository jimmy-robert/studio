import 'dart:async';

import 'package:flutter/services.dart';

export 'package:dio/dio.dart' show FormData, MultipartFile;
export 'package:http_parser/http_parser.dart' show MediaType;
export 'package:studio/src/core/app/app.dart';
export 'package:studio/src/core/dependencies/dependency.dart';
export 'package:studio/src/core/dependencies/dependency_not_found_exception.dart';
export 'package:studio/src/core/dependencies/dependency_resolver.dart';
export 'package:studio/src/core/lifecycle/auto_create.dart';
export 'package:studio/src/core/lifecycle/lifecycle.dart';
export 'package:studio/src/core/reactive/observable.dart';
export 'package:studio/src/core/reactive/observer.dart';
export 'package:studio/src/core/screen/screen.dart';
export 'package:studio/src/core/screen/screen_controller.dart';
export 'package:studio/src/core/serializer/serializable.dart';
export 'package:studio/src/core/serializer/serialization_scope.dart';
export 'package:studio/src/core/serializer/serialized.dart';
export 'package:studio/src/core/serializer/serializer.dart';
export 'package:studio/src/types/value_predicate.dart';
export 'package:studio/src/utils/cast.dart';
export 'package:studio/src/utils/duration.dart';
export 'package:studio/src/utils/lists.dart';
export 'package:studio/src/utils/number.dart';
export 'package:studio/src/utils/type.dart';
export 'package:studio/src/widgets/restart_widget.dart';

class Studio {
  static const _channel = MethodChannel('studio');

  static Future<String?> get platformVersion async {
    return await _channel.invokeMethod<String>('getPlatformVersion');
  }
}
