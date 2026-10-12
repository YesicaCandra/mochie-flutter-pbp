import 'dart:ui' show PointerDeviceKind;

import 'package:flutter/material.dart';

import 'pages/login_page.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MochieApp());
}

// Mengizinkan geser (drag) dengan mouse dan trackpad,
// supaya daftar horizontal bisa digeser di browser/desktop.
class MochieScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.trackpad,
    PointerDeviceKind.stylus,
  };
}

class MochieApp extends StatelessWidget {
  const MochieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MOCHIÉ',
      theme: AppTheme.theme,
      scrollBehavior: MochieScrollBehavior(),
      home: const LoginPage(),
    );
  }
}
