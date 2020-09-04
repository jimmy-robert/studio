import 'package:flutter/material.dart';

class ValueSelector<T> extends StatelessWidget {
  final List<ValueSelectorItem<T>> items;
  final String title;

  const ValueSelector({
    Key key,
    @required this.items,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title ?? '')),
      body: ListView.separated(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return ListTile(
            title: Text(item.title),
            onTap: () => Navigator.of(context).pop(item.value),
          );
        },
        separatorBuilder: (context, index) => const Divider(),
      ),
    );
  }

  static Future<T> select<T>({
    @required BuildContext context,
    @required List<ValueSelectorItem<T>> items,
    @required String title,
  }) {
    final route = MaterialPageRoute<T>(
      builder: (context) => ValueSelector<T>(items: items, title: title),
    );
    return Navigator.of(context).push(route);
  }
}

class ValueSelectorItem<T> {
  final String title;
  final T value;

  const ValueSelectorItem(this.title, this.value);
}
