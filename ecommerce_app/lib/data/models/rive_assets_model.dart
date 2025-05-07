import 'package:ecommerce_app/presentation/screens/admin/user_manager_screen.dart';
import 'package:ecommerce_app/presentation/screens/dashboard/admin_dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class RiveAssetsModel {
  final String artboard, stateMachineName, title, src;
  late SMIBool? input;
  final Widget screenWidget;
 
  RiveAssetsModel(
    this.src, {
    required this.artboard,
    required this.stateMachineName,
    required this.title,
    this.input,
    required this.screenWidget, 
  });

  set setInput(SMIBool status) {
    input = status;
  }
}

List<RiveAssetsModel> sideMenus = [
  RiveAssetsModel(
    "assets/RiveAssets/icons.riv",
    artboard: "HOME",
    stateMachineName: "HOME_interactivity",
    title: "Trang chủ",
    screenWidget: const AdminDashboardScreen(),
  ),
  RiveAssetsModel(
    "assets/RiveAssets/icons.riv",
    artboard: "USER",
    stateMachineName: "USER_Interactivity",
    title: "Người dùng",
    screenWidget: const UserManagerScreen(),
  ),
  RiveAssetsModel(
    "assets/RiveAssets/icons.riv",
    artboard: "REFRESH/RELOAD",
    stateMachineName: "RELOAD_Interactivity",
    title: "Danh mục",
    screenWidget: const UserManagerScreen(),
  ),
  RiveAssetsModel(
    "assets/RiveAssets/icons.riv",
    artboard: "REFRESH/RELOAD",
    stateMachineName: "RELOAD_Interactivity",
    title: "Sản phẩm",
    screenWidget: const UserManagerScreen(),
  ),
];

// List<RiveAssetsModel> bottomNavs = [
//   RiveAssetsModel(
//     "assets/RiveAssets/icons.riv",
//     artboard: "CHAT",
//     stateMachineName: "CHAT_Interactivity",
//     title: "Chat",
//   ),
//   RiveAssetsModel(
//     "assets/RiveAssets/icons.riv",
//     artboard: "SEARCH",
//     stateMachineName: "SEARCH_Interactivity",
//     title: "Search",
//   ),
//   RiveAssetsModel(
//     "assets/RiveAssets/icons.riv",
//     artboard: "TIMER",
//     stateMachineName: "TIMER_Interactivity",
//     title: "Timer",
//   ),
//   RiveAssetsModel(
//     "assets/RiveAssets/icons.riv",
//     artboard: "BELL",
//     stateMachineName: "BELL_Interactivity",
//     title: "Notifications",
//   ),
//   RiveAssetsModel(
//     "assets/RiveAssets/icons.riv",
//     artboard: "USER",
//     stateMachineName: "USER_Interactivity",
//     title: "Profile",
//   ),
// ];
