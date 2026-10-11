import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

// Field berlabel (label di atas) untuk halaman Login dan Register.
// Parameter lama tetap sama; parameter baru bersifat opsional.
class CustomTextField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData? icon;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? errorText;
  final Widget? suffixIcon;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.icon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.errorText,
    this.suffixIcon,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppTheme.cocoa,
            fontWeight: FontWeight.w800,
            fontSize: 13,
          ),
        ),

        const SizedBox(height: 6),

        TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          style: const TextStyle(
            color: AppTheme.cocoa,
            fontWeight: FontWeight.w700,
          ),
          decoration: InputDecoration(
            hintText: hint,
            errorText: errorText,
            fillColor: AppTheme.cream,
            prefixIcon: icon == null
                ? null
                : Icon(icon, color: AppTheme.primaryDeep, size: 20),
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}
