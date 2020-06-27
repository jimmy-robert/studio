import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provided.dart';

extension ContextProviderExtension on BuildContext {
  T get<T extends Provided>({bool allowNull = true}) {
    try {
      return read<T>();
    } on ProviderNotFoundException {
      if (!allowNull) rethrow;
      return null;
    }
  }
}
