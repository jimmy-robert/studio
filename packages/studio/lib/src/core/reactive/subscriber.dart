import 'dart:async';

import 'package:studio/studio.dart';

mixin Subscriber on Lifecycle {
  final subscriptions = <StreamSubscription>[];

  void listen<T>(Stream<T> stream, void Function(T value) onValue) {
    subscriptions.add(stream.listen(onValue));
  }

  @override
  void onDestroy() {
    super.onDestroy();

    for (final subscription in subscriptions) {
      subscription.cancel();
    }
  }
}
