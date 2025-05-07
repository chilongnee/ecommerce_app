import 'package:ecommerce_app/core/constants/colors.dart';
import 'package:ecommerce_app/core/utils/rive_utils.dart';
import 'package:ecommerce_app/data/models/rive_assets_model.dart';
import 'package:ecommerce_app/presentation/widgets/bar/side_menu_tile.dart';
import 'package:ecommerce_app/presentation/widgets/card/info_card.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class SideBar extends StatefulWidget {
  final RiveAssetsModel selectedMenu;
  final Function(RiveAssetsModel) onMenuSelected;

  const SideBar({
    super.key,
    required this.selectedMenu,
    required this.onMenuSelected,
  });

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  // RiveAssetsModel selectedMenu = sideMenus.first;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 288,
      height: double.infinity,
      color: AppColors.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InfoCard(name: 'Admin', role: 'Admin'),
          Padding(
            padding: const EdgeInsets.only(left: 24, top: 32, bottom: 12),
            child: Text(
              'Chức năng'.toUpperCase(),
              style: Theme.of(
                context,
              ).textTheme.titleMedium!.copyWith(color: Colors.white70),
            ),
          ),
          ...sideMenus.map(
            (menu) => SideMenuTile(
              menu: menu,
              riveonInit: (artboard) {
                StateMachineController controller = RiveUtils.getRiveController(
                  artboard,
                  stateMachineName: menu.stateMachineName,
                );
                menu.input = controller.findSMI('active') as SMIBool;
              },
              press: () {
                menu.input!.change(true);
                Future.delayed(Duration(seconds: 1), () {
                  menu.input!.change(false);
                });
                // setState(() {
                //   selectedMenu = menu;
                // });

                widget.onMenuSelected(menu);
              },
              isActive: widget.selectedMenu == menu,
            ),
          ),
        ],
      ),
    );
  }
}
