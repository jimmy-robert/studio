import 'package:flutter/material.dart';

import '../app/app.dart';

mixin DevTools on App {
  @override
  Widget buildApp(BuildContext context, Widget child) {
    child = super.buildApp(context, child);
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.grey.shade800,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 8,
              offset: Offset.zero,
            )
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: child,
      ),
    );
  }
}
