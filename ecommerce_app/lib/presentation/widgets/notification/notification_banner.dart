import 'package:ecommerce_app/core/constants/colors.dart';
import 'package:flutter/material.dart';

enum NotificationType { success, error, warning, info }

class NotificationBanner extends StatelessWidget {
  final String message;
  final NotificationType type;

  const NotificationBanner({
    super.key,
    required this.message,
    this.type = NotificationType.info,
  });

  Color _getBackgroundColor() {
    switch (type) {
      case NotificationType.success:
        return AppColors.success;
      case NotificationType.error:
        return AppColors.error;
      case NotificationType.warning:
        return AppColors.warning;
      case NotificationType.info:
        return AppColors.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: _getBackgroundColor(),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            message,
            style: const TextStyle(color: AppColors.textWhite),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
