import 'package:flutter/material.dart';

import 'pages/login_page.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MochieApp());
}

class MochieApp extends StatelessWidget {
  const MochieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MOCHIÉ',
      theme: AppTheme.theme,
      home: const LoginPage(),
    );
  }
}
