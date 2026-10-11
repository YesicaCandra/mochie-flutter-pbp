import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

// Snackbar seragam. Warna, bentuk, dan font diambil dari AppTheme.
class AppSnackBar {
  static void show(
    BuildContext context,
    String message, {
    IconData? icon,
    SnackBarAction? action,
    Duration duration = const Duration(seconds: 2),
  }) {
    final messenger = ScaffoldMessenger.of(context);

    messenger.hideCurrentSnackBar();

    messenger.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        duration: duration,
        action: action,
        content: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, color: AppTheme.white, size: 20),
              const SizedBox(width: 10),
            ],
            Expanded(child: Text(message)),
          ],
        ),
      ),
    );
  }

  // Pesan berhasil (ikon centang).
  static void success(
    BuildContext context,
    String message, {
    SnackBarAction? action,
  }) {
    show(
      context,
      message,
      icon: Icons.check_circle_outline_rounded,
      action: action,
    );
  }

  // Pesan peringatan atau error (ikon tanda seru).
  static void error(BuildContext context, String message) {
    show(context, message, icon: Icons.error_outline_rounded);
  }
}
