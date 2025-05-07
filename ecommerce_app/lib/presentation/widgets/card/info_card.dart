import 'package:ecommerce_app/core/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String name, role;

  const InfoCard({super.key, required this.name, required this.role});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.white24,
        child: Icon(CupertinoIcons.person, color: AppColors.secondary),
      ),
      title: Text(name, style: TextStyle(color: AppColors.textWhite)),
      subtitle: Text(role, style: TextStyle(color: AppColors.textWhite)),
    );
  }
}