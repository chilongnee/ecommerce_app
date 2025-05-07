import 'dart:math';
import 'package:ecommerce_app/core/constants/colors.dart';
import 'package:ecommerce_app/core/utils/rive_utils.dart';
import 'package:ecommerce_app/data/models/rive_assets_model.dart';
import 'package:ecommerce_app/presentation/screens/admin/admin_home_screen.dart';
import 'package:ecommerce_app/presentation/widgets/bar/custom_sidebar.dart';
import 'package:ecommerce_app/presentation/widgets/button/menu_button.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> animation;
  late Animation<double> scaleAnimation;

  late SMITrigger isSideBarOpened;
  late SMITrigger isSideBarClosed;
  bool isSideMenuClosed = true;

  RiveAssetsModel selectedMenu = sideMenus.first;
  Widget selectedScreen = const AdminHomeScreen();

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    )..addListener(() {
      setState(() {});
    });
    animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );
    scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primary,
        resizeToAvoidBottomInset: false,
        extendBody: true,
        body: Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: 200),
              curve: Curves.fastOutSlowIn,
              width: 288,
              left: isSideMenuClosed ? -288 : 0,
              height: MediaQuery.of(context).size.height,
              child: SideBar(
                selectedMenu: selectedMenu,
                onMenuSelected: (menu) {
                  setState(() {
                    selectedMenu = menu;
                    selectedScreen = menu.screenWidget;
                  });
                },
              ),
            ),

            Transform(
              alignment: Alignment.center,
              transform:
                  Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(
                      animation.value - 30 * animation.value * pi / 180,
                    ),
              child: Transform.translate(
                offset: Offset(animation.value * 265, 0),
                child: Transform.scale(
                  scale: scaleAnimation.value,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(24)),
                    child:
                        isSideMenuClosed
                            ? selectedScreen
                            : GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                isSideBarClosed.fire();
                                _animationController.reverse();
                                setState(() {
                                  isSideMenuClosed = !isSideMenuClosed;
                                });
                              },
                              child: selectedScreen,
                            ),
                  ),
                ),
              ),
            ),

            AnimatedPositioned(
              duration: Duration(milliseconds: 200),
              curve: Curves.fastOutSlowIn,
              left: isSideMenuClosed ? 0 : 220,
              top: 16,
              child: MenuButton(
                riveOnInit: (artboard) {
                  StateMachineController controller =
                      RiveUtils.getRiveController(
                        artboard,
                        stateMachineName: "State Machine 1",
                      );
                  isSideBarOpened =
                      controller.findSMI("First-click") as SMITrigger;
                  isSideBarClosed =
                      controller.findSMI("Second-click") as SMITrigger;

                  // isSideBarClosed.value = true;
                  // print("is side bar closed: $isSideBarClosed");
                },
                press: () {
                  if (isSideMenuClosed) {
                    isSideBarOpened.fire();
                    _animationController.forward();
                  } else {
                    isSideBarClosed.fire();
                    _animationController.reverse();
                  }
                  setState(() {
                    isSideMenuClosed = !isSideMenuClosed;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
