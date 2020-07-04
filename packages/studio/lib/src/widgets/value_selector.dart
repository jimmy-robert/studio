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
      appBar: AppBar(title: Text(title)),
      body: ListView.separated(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return ListTile(
            title: Text(item.title),
            onTap: () {
              Navigator.of(context).pop<dynamic>(item.value);
            },
          );
        },
        separatorBuilder: (context, index) => const Divider(),
      ),
    );
  }
}

class ValueSelectorItem<T> {
  const ValueSelectorItem(this.title, this.value);

  final String title;
  final T value;
}
