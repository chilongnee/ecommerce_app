import 'package:ecommerce_app/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class MenuButton extends StatelessWidget {
  final VoidCallback press;
  final ValueChanged<Artboard> riveOnInit;

  const MenuButton({super.key, required this.press, required this.riveOnInit});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: press,
        child: Container(
          margin: EdgeInsets.only(left: 16),
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: AppColors.secondary,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 3),
                blurRadius: 8,
              ),
            ],
          ),
          child: RiveAnimation.asset(
            "assets/RiveAssets/menu_icon.riv",
            onInit: riveOnInit,
          ),
        ),
      ),
    );
  }
}
