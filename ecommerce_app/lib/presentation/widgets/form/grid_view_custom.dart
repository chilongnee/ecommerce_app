import 'package:flutter/material.dart';

class GridViewCustom<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function(T item) itemBuilder;
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double childAspectRatio;
  final EdgeInsetsGeometry padding;

  const GridViewCustom({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.crossAxisCount = 2,
    this.mainAxisSpacing = 10,
    this.crossAxisSpacing = 10,
    this.childAspectRatio = 1.3,
    this.padding = const EdgeInsets.only(left: 0, right: 10, top: 10, bottom: 0),
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: padding,
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: mainAxisSpacing,
        crossAxisSpacing: crossAxisSpacing,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) => itemBuilder(items[index]),
    );
  }
}
