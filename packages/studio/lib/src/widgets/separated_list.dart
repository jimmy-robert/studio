import 'package:flutter/material.dart';

class SeparatedList extends StatelessWidget {
  final List<Widget> children;

  SeparatedList({Key key, @required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: AlwaysScrollableScrollPhysics(),
      itemCount: children.length,
      itemBuilder: (context, index) => children[index],
      separatorBuilder: (context, index) => Divider(),
    );
  }
}
