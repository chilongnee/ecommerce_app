import 'package:ecommerce_app/presentation/screens/admin/user_manager_screen.dart';
import 'package:ecommerce_app/presentation/screens/dashboard/admin_dashboard_screen.dart';
import 'package:ecommerce_app/presentation/screens/dashboard/dashboard_screen.dart';
import 'package:ecommerce_app/presentation/screens/auth/login_screen.dart';
import 'package:ecommerce_app/presentation/screens/auth/register_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String splash = '/';
  // AUTH
  static const String login = '/login';
  static const String register = '/register';
  // USER
  static const String dashboard = '/dashboard';
  // ADMIN
  static const String adminDashboard = '/adminDashboard';
  static const String userManagerScreen = '/userManager';


  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch(settings.name) {
      case dashboard:
        return MaterialPageRoute(builder: (_) => const DashboardScreen()); 
      // ADMIN
      case adminDashboard:
        return MaterialPageRoute(builder: (_) => const AdminDashboardScreen()); 
      case userManagerScreen:
        return MaterialPageRoute(builder: (_) => const UserManagerScreen()); 
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('Không tìm thấy route: ${settings.name}'),
            ),
          ),
        );
    }
  }
}