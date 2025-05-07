import 'package:ecommerce_app/core/config/firebase_options.dart';
import 'package:ecommerce_app/core/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: AppRoutes.generateRoute,
      initialRoute: AppRoutes.adminDashboard,
      debugShowCheckedModeBanner: false,
    );
  }
}
