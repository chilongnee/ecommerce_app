import 'package:flutter/material.dart';

class ListViewCustom<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function(T item) itemBuilder;

  const ListViewCustom({
    super.key,
    required this.items,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) => itemBuilder(items[index]),
    );
  }
}
