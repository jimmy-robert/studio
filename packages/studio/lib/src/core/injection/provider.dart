import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;

import '../lifecycle/lifecycle.dart';
import 'resolver.dart';

class Provider<T> extends StatelessWidget {
  final T Function() create;

  final Widget child;

  final bool lazy;

  const Provider._(this.create, {this.lazy, this.child});

  const Provider(this.create, {this.lazy, this.child});

  const factory Provider.context(
    T Function(BuildContext context) create, {
    bool lazy,
    Widget child,
  }) = _ProviderWithContext<T>;

  const factory Provider.value(T value, {Widget child}) = _ProviderValue<T>;

  @override
  Widget build(BuildContext context) {
    return provider.Provider<_Provider<T>>(
      create: (context) {
        final _provider = _Provider<T>(
          context: context,
          create: create,
          lazy: lazy,
        );

        final value = _provider.value = _provider.create();

        if (value is ProxyResolver) value.resolver = _ContextResolver(context);
        if (value is Lifecycle) value.onCreate();

        return _provider;
      },
      dispose: (context, provider) {
        final value = provider.value;

        if (value is Lifecycle) value.onDispose();
        if (value is ProxyResolver) value.resolver = null;

        provider.value = null;
        provider.context = null;
      },
      lazy: lazy,
      child: child,
    );
  }

  Provider<T> copyWith(Widget child) {
    return Provider<T>._(create, lazy: lazy, child: child);
  }

  static T of<T>(BuildContext context, {bool allowNull = true}) {
    try {
      return provider.Provider.of<_Provider<T>>(context, listen: false).value;
    } on provider.ProviderNotFoundException {
      if (allowNull) return null;
      rethrow;
    }
  }
}

class _ProviderValue<T> extends Provider<T> {
  final T value;

  const _ProviderValue(this.value, {Widget child}) : super._(null, lazy: false, child: child);

  @override
  Widget build(BuildContext context) {
    final _provider = _Provider<T>(create: null, context: null, factory: false, lazy: false);
    _provider.value = value;
    return provider.Provider<_Provider<T>>.value(value: _provider, child: child);
  }

  @override
  Provider<T> copyWith(Widget child) {
    return _ProviderValue<T>(value, child: child);
  }
}

class _ProviderWithContext<T> extends Provider<T> {
  final T Function(BuildContext context) contextCreate;

  const _ProviderWithContext(this.contextCreate, {bool lazy, Widget child}) : super._(null, lazy: lazy, child: child);

  @override
  Widget build(BuildContext context) {
    return provider.Provider<_Provider<T>>(
      create: (context) {
        final _provider = _Provider<T>(
          context: context,
          create: () => contextCreate(context),
          lazy: lazy,
          factory: false,
        );

        final value = _provider.value = contextCreate(context);
        if (value is ProxyResolver) value.resolver = _ContextResolver(context);
        if (value is Lifecycle) value.onCreate();

        return _provider;
      },
      dispose: (context, provider) {
        final value = provider.value;

        if (value is Lifecycle) value.onDispose();
        if (value is ProxyResolver) value.resolver = null;

        provider.value = null;
        provider.context = null;
      },
      lazy: lazy,
      child: child,
    );
  }

  @override
  Provider<T> copyWith(Widget child) {
    return _ProviderWithContext(contextCreate, lazy: lazy, child: child);
  }
}

class _Provider<T> {
  BuildContext context;

  T value;

  final T Function() create;

  final bool lazy;

  final bool factory;

  _Provider({this.context, this.create, this.lazy, this.factory});
}

extension ContextProviderExtension on BuildContext {
  T resolve<T>({bool allowNull = true}) {
    return Provider.of<T>(this, allowNull: allowNull);
  }
}

class _ContextResolver with Resolver {
  final BuildContext context;

  const _ContextResolver(this.context);

  @override
  T resolve<T>({bool allowNull = true}) => context.resolve(allowNull: allowNull);
}
