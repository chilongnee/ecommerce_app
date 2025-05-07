import 'package:ecommerce_app/core/constants/colors.dart';
import 'package:ecommerce_app/data/models/rive_assets_model.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class SideMenuTile extends StatelessWidget {
  final RiveAssetsModel menu;
  final VoidCallback press;
  final ValueChanged<Artboard> riveonInit;
  final bool isActive;

  const SideMenuTile({
    super.key,
    required this.menu,
    required this.press,
    required this.riveonInit,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Divider(color: Colors.white24, height: 1),
        ),

        Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              height: 50,
              width: isActive ? 288 : 0,
              left: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.backgroundLight,
                  // borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            ListTile(
              onTap: press,
              leading: SizedBox(
                height: 34,
                width: 34,
                child: RiveAnimation.asset(
                  menu.src,
                  artboard: menu.artboard,
                  onInit: riveonInit,
                ),
              ),
              title: Text(
                menu.title,
                style: TextStyle(color: AppColors.textWhite),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
