import 'dart:core';
import 'dart:core' as core;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:studio/src/core/dependencies/dependency_not_found_exception.dart';
import 'package:studio/src/core/dependencies/dependency_resolver.dart';
import 'package:studio/src/core/lifecycle/auto_create.dart';
import 'package:studio/src/core/lifecycle/lifecycle.dart';

import 'package:studio/src/utils/lists.dart';
import 'package:studio/src/utils/type.dart';

part 'module.dart';

class Dependency<T> extends StatelessWidget {
  final Type type = T;

  final Provider<T> _provider;

  Dependency({
    required ValueGetter<T> create,
    Widget? child,
    bool? lazy,
  }) : _provider = Provider<T>(
          create: (context) {
            final value = create();
            if (value is DependencyProxyResolver) value.resolver = _ContextResolver(context);
            if (value is Lifecycle) value.onCreate();
            return value;
          },
          dispose: (context, value) {
            if (value is Lifecycle) value.onDestroy();
            if (value is DependencyProxyResolver) value.resolver = null;
          },
          lazy: lazy ?? !isSubType<T, AutoCreate>(),
          child: child,
        );

  Dependency.value({
    required T value,
    Widget? child,
  }) : _provider = Provider.value(
          value: value,
          child: child,
        );

  static Dependency<Factory<F>> factory<F>(ValueGetter<F> create) {
    return Dependency.value(value: Factory(create));
  }

  @override
  Widget build(BuildContext context) => _provider;

  static T resolve<T>(BuildContext context, {T Function()? orElse}) {
    try {
      return Provider.of<T>(context, listen: false);
    } on ProviderNotFoundException catch (error) {
      if (orElse != null) return orElse();
      throw DependencyNotFoundException(error.valueType, error.widgetType);
    }
  }

  static T? maybeResolve<T>(BuildContext context) {
    try {
      return Provider.of<T>(context, listen: false);
    } on ProviderNotFoundException {
      return null;
    }
  }
}

class _ContextResolver with DependencyResolver {
  final BuildContext context;

  _ContextResolver(this.context);

  @override
  T resolve<T>() => Dependency.resolve<T>(context);

  @override
  T? maybeResolve<T>() => Dependency.maybeResolve<T>(context);
}
