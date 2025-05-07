// notification_utils.dart
import 'package:flutter/material.dart';
import 'package:ecommerce_app/presentation/widgets/notification/notification_banner.dart';

void showNotificationBanner(
  BuildContext context,
  String message, {
  NotificationType type = NotificationType.info,
}) {
  final overlay = Overlay.of(context);
  final entry = OverlayEntry(
    builder: (_) => Positioned(
      bottom: 20,
      left: 20,
      right: 20,
      child: NotificationBanner(message: message, type: type),
    ),
  );

  overlay.insert(entry);

  Future.delayed(const Duration(seconds: 3), () => entry.remove());
}
