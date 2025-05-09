import 'package:flutter/material.dart';

class CustomCircular extends StatelessWidget {
  final double? width;
  final double? height;
  final double radius;
  final double padding;
  final Widget? child;
  final Color backgroundColor;

  const CustomCircular({
    super.key,
    this.child,
    this.width = 400,
    this.height = 400,
    this.radius = 400,
    this.padding = 0,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 400,
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(400),
        color: Colors.white.withOpacity(0.1),
      ),
      child: child,
    );
  }
}