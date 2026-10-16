import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/animated_mochi_background.dart';
import '../widgets/app_snackbar.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/gradient_button.dart';

// Halaman Register (tampilan saja).
// Validasi dilakukan lokal. Akun tidak disimpan ke mana pun,
// karena aplikasi belum terhubung ke sistem akun.
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmVisible = false;

  String? _nameError;
  String? _emailError;
  String? _passwordError;
  String? _confirmError;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email);
  }

  // =========================================================
  // DAFTAR
  // =========================================================

  void _register() {
    FocusScope.of(context).unfocus();

    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirm = _confirmController.text.trim();

    String? nameError;
    String? emailError;
    String? passwordError;
    String? confirmError;

    if (name.isEmpty) {
      nameError = 'Nama belum diisi';
    }

    if (email.isEmpty) {
      emailError = 'Email belum diisi';
    } else if (!_isValidEmail(email)) {
      emailError = 'Masukkan alamat email yang valid';
    }

    if (password.isEmpty) {
      passwordError = 'Password belum diisi';
    } else if (password.length < 6) {
      passwordError = 'Password minimal 6 karakter';
    }

    if (confirm.isEmpty) {
      confirmError = 'Konfirmasi password belum diisi';
    } else if (confirm != password) {
      confirmError = 'Password tidak sama';
    }

    setState(() {
      _nameError = nameError;
      _emailError = emailError;
      _passwordError = passwordError;
      _confirmError = confirmError;
    });

    final hasError =
        nameError != null ||
        emailError != null ||
        passwordError != null ||
        confirmError != null;

    if (hasError) {
      return;
    }

    AppSnackBar.success(context, 'Akun berhasil dibuat! Silakan masuk.');

    Navigator.pop(context);
  }

  Widget _visibilityButton({
    required bool visible,
    required VoidCallback onPressed,
  }) {
    return IconButton(
      tooltip: visible ? 'Sembunyikan password' : 'Tampilkan password',
      onPressed: onPressed,
      icon: Icon(
        visible ? Icons.visibility_off_outlined : Icons.visibility_outlined,
        color: AppTheme.primaryDeep,
      ),
    );
  }

  // =========================================================
  // BUILD
  // =========================================================

  // Judul besar di sisi kiri pada layar lebar (selaras dengan Login).
  Widget _buildWideHeading() {
    return const Positioned(
      left: 64,
      top: 0,
      bottom: 0,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Buat Akun',
              style: TextStyle(
                fontFamily: AppTheme.fontDisplay,
                fontSize: 72,
                fontWeight: FontWeight.w600,
                height: 1,
                color: AppTheme.primaryDeep,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Gabung dan nikmati manisnya Mochié',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.5,
                color: AppTheme.cocoa,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Judul besar di kiri hanya jika ruang cukup, agar tidak bertumpuk.
    final isWide = MediaQuery.sizeOf(context).width >= 960;

    return Scaffold(
      backgroundColor: AppTheme.cream,
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: AnimatedMochiBackground(
        child: SafeArea(
          child: Stack(
            children: [
              if (isWide) _buildWideHeading(),
              Align(
                alignment: isWide ? Alignment.centerRight : Alignment.center,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(24, 48, isWide ? 96 : 24, 24),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (!isWide) ...[
                          const Text(
                            'Buat Akun',
                            style: TextStyle(
                              fontFamily: AppTheme.fontDisplay,
                              fontSize: 34,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.primaryDeep,
                            ),
                          ),

                          const Text(
                            'Gabung dan nikmati manisnya Mochié',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                              color: AppTheme.cocoa,
                            ),
                          ),

                          const SizedBox(height: 20),
                        ],

                        ClipRRect(
                          borderRadius: BorderRadius.circular(28),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(22),
                              decoration: BoxDecoration(
                                color: AppTheme.white.withValues(alpha: 0.9),
                                borderRadius: BorderRadius.circular(28),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppTheme.primary.withValues(
                                      alpha: 0.16,
                                    ),
                                    blurRadius: 28,
                                    offset: const Offset(0, 12),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  CustomTextField(
                                    label: 'Nama',
                                    hint: 'Nama lengkap',
                                    controller: _nameController,
                                    errorText: _nameError,
                                    textInputAction: TextInputAction.next,
                                    onChanged: (_) {
                                      if (_nameError != null) {
                                        setState(() {
                                          _nameError = null;
                                        });
                                      }
                                    },
                                  ),

                                  const SizedBox(height: 12),

                                  CustomTextField(
                                    label: 'Email',
                                    hint: 'nama@email.com',
                                    controller: _emailController,
                                    errorText: _emailError,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                    onChanged: (_) {
                                      if (_emailError != null) {
                                        setState(() {
                                          _emailError = null;
                                        });
                                      }
                                    },
                                  ),

                                  const SizedBox(height: 12),

                                  CustomTextField(
                                    label: 'Password',
                                    hint: 'Minimal 6 karakter',
                                    controller: _passwordController,
                                    errorText: _passwordError,
                                    obscureText: !_isPasswordVisible,
                                    textInputAction: TextInputAction.next,
                                    suffixIcon: _visibilityButton(
                                      visible: _isPasswordVisible,
                                      onPressed: () {
                                        setState(() {
                                          _isPasswordVisible =
                                              !_isPasswordVisible;
                                        });
                                      },
                                    ),
                                    onChanged: (_) {
                                      if (_passwordError != null) {
                                        setState(() {
                                          _passwordError = null;
                                        });
                                      }
                                    },
                                  ),

                                  const SizedBox(height: 12),

                                  CustomTextField(
                                    label: 'Konfirmasi Password',
                                    hint: 'Ulangi password',
                                    controller: _confirmController,
                                    errorText: _confirmError,
                                    obscureText: !_isConfirmVisible,
                                    textInputAction: TextInputAction.done,
                                    onSubmitted: (_) {
                                      _register();
                                    },
                                    suffixIcon: _visibilityButton(
                                      visible: _isConfirmVisible,
                                      onPressed: () {
                                        setState(() {
                                          _isConfirmVisible =
                                              !_isConfirmVisible;
                                        });
                                      },
                                    ),
                                    onChanged: (_) {
                                      if (_confirmError != null) {
                                        setState(() {
                                          _confirmError = null;
                                        });
                                      }
                                    },
                                  ),

                                  const SizedBox(height: 18),

                                  SizedBox(
                                    width: double.infinity,
                                    child: GradientButton(
                                      label: 'Daftar',
                                      onPressed: _register,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Sudah punya akun? ',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: AppTheme.cocoa,
                              ),
                            ),

                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(0, 36),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: const Text(
                                'Masuk',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w800,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
