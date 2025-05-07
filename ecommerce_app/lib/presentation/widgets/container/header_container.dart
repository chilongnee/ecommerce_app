import 'package:ecommerce_app/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/presentation/widgets/custom_shape/curved_widget.dart';
import 'package:ecommerce_app/presentation/widgets/custom_shape/custom_circular.dart';

class HeaderContainer extends StatelessWidget {
  final Widget child;
  final Color? headerColor;

  const HeaderContainer({
    super.key,
    required this.child,
    this.headerColor,
  });

  @override
  Widget build(BuildContext context) {
    return CurvedWidget(
      child: Container(
        color: headerColor,
        padding: const EdgeInsets.all(0),
        child: Stack(
          children: [
            Positioned(
              top: -150,
              right: -250,
              child: CustomCircular(
                backgroundColor: AppColors.primary.withOpacity(0.1),
              ),
            ),
            Positioned(
              top: 100,
              right: -300,
              child: CustomCircular(
                backgroundColor: AppColors.primary.withOpacity(0.1),
              ),
            ),
            child,
          ],
        ),
      ),
    );
  }
}
