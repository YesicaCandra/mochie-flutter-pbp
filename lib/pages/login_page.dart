import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // =========================================================
  // CONTROLLER
  // =========================================================

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  // =========================================================
  // STATE
  // =========================================================

  bool isPasswordVisible = false;
  bool rememberMe = true;
  bool isLoading = false;

  // =========================================================
  // DISPOSE
  // =========================================================

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // =========================================================
  // LOGIN
  // =========================================================

  Future<void> login() async {
    FocusScope.of(context).unfocus();

    final String email = emailController.text.trim();

    final String password = passwordController.text.trim();

    // ---------------------------------------------------------
    // VALIDASI EMAIL
    // ---------------------------------------------------------

    if (email.isEmpty) {
      _showMessage('Email belum diisi.', Icons.email_outlined);
      return;
    }

    if (!_isValidEmail(email)) {
      _showMessage(
        'Masukkan alamat email yang valid.',
        Icons.warning_amber_rounded,
      );
      return;
    }

    // ---------------------------------------------------------
    // VALIDASI PASSWORD
    // ---------------------------------------------------------

    if (password.isEmpty) {
      _showMessage('Password belum diisi.', Icons.lock_outline);
      return;
    }

    if (password.length < 6) {
      _showMessage('Password minimal 6 karakter.', Icons.lock_outline);
      return;
    }

    // ---------------------------------------------------------
    // LOADING
    // ---------------------------------------------------------

    setState(() {
      isLoading = true;
    });

    // Simulasi proses login.
    await Future.delayed(const Duration(milliseconds: 900));

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });

    // ---------------------------------------------------------
    // MASUK KE HOME
    // ---------------------------------------------------------

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  // =========================================================
  // VALIDASI EMAIL
  // =========================================================

  bool _isValidEmail(String email) {
    return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email);
  }

  // =========================================================
  // SNACKBAR
  // =========================================================

  void _showMessage(String message, IconData icon) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.fromLTRB(18, 0, 18, 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: AppTheme.darkPlum,
          content: Row(
            children: [
              Icon(icon, color: AppTheme.white, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(
                    color: AppTheme.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }

  // =========================================================
  // FORGOT PASSWORD
  // =========================================================

  void _showForgotPassword() {
    final TextEditingController forgotController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppTheme.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
          ),
          title: const Text(
            'Forgot Password?',
            style: TextStyle(
              color: AppTheme.darkPlum,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Masukkan email kamu. Fitur reset password dapat digunakan setelah aplikasi terhubung ke sistem akun.',
                style: TextStyle(
                  color: AppTheme.darkPlum.withValues(alpha: 0.65),
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 18),
              TextField(
                controller: forgotController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Email kamu',
                  prefixIcon: const Icon(Icons.email_outlined),
                  filled: true,
                  fillColor: AppTheme.cream,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text(
                'Batal',
                style: TextStyle(color: AppTheme.darkPlum),
              ),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: AppTheme.darkPlum,
                foregroundColor: AppTheme.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: () {
                final email = forgotController.text.trim();

                if (email.isEmpty || !_isValidEmail(email)) {
                  _showMessage(
                    'Masukkan email yang valid.',
                    Icons.warning_amber_rounded,
                  );
                  return;
                }

                Navigator.pop(dialogContext);

                _showMessage(
                  'Instruksi reset password akan dikirim ke $email.',
                  Icons.mark_email_read_outlined,
                );
              },
              child: const Text('Kirim'),
            ),
          ],
        );
      },
    );
  }

  // =========================================================
  // GUEST LOGIN
  // =========================================================

  void _continueAsGuest() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.cream,
      body: Stack(
        children: [
          // ===================================================
          // BACKGROUND DECORATION
          // ===================================================

          Positioned(
            top: -100,
            right: -80,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                color: AppTheme.dustyRose.withValues(alpha: 0.55),
                shape: BoxShape.circle,
              ),
            ),
          ),

          Positioned(
            bottom: -90,
            left: -100,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                color: AppTheme.softPink.withValues(alpha: 0.9),
                shape: BoxShape.circle,
              ),
            ),
          ),

          // Dekorasi kecil
          const Positioned(
            top: 90,
            left: 28,
            child: Text(
              '✦',
              style: TextStyle(fontSize: 18, color: AppTheme.dustyRoseDark),
            ),
          ),

          const Positioned(
            top: 160,
            right: 32,
            child: Text(
              '♡',
              style: TextStyle(fontSize: 22, color: AppTheme.dustyRoseDark),
            ),
          ),

          // ===================================================
          // MAIN CONTENT
          // ===================================================
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(22, 22, 22, 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ===========================================
                  // BRAND
                  // ===========================================

                  Center(
                    child: Column(
                      children: [
                        Container(
                          width: 82,
                          height: 82,
                          decoration: BoxDecoration(
                            color: AppTheme.white,
                            borderRadius: BorderRadius.circular(28),
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.dustyRoseDark.withValues(
                                  alpha: 0.15,
                                ),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(28),
                            child: Image.asset(
                              'assets/images/mochie_logo.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),

                        const SizedBox(height: 15),

                        const Text(
                          'Mochié',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.8,
                            color: AppTheme.darkPlum,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          'A little sweetness for your day.',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppTheme.dustyRoseDark,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // ===========================================
                  // LOGIN CARD
                  // ===========================================
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(22, 24, 22, 22),
                    decoration: BoxDecoration(
                      color: AppTheme.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.dustyRoseDark.withValues(alpha: 0.12),
                          blurRadius: 28,
                          offset: const Offset(0, 12),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Welcome back 👋',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.darkPlum,
                          ),
                        ),

                        const SizedBox(height: 7),

                        Text(
                          'Masuk untuk melanjutkan perjalanan manismu bersama Mochié.',
                          style: TextStyle(
                            fontSize: 13,
                            height: 1.45,
                            color: AppTheme.darkPlum.withValues(alpha: 0.58),
                          ),
                        ),

                        const SizedBox(height: 25),

                        // =====================================
                        // EMAIL
                        // =====================================
                        const Text(
                          'Email',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.darkPlum,
                          ),
                        ),

                        const SizedBox(height: 8),

                        TextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: _inputDecoration(
                            hint: 'nama@email.com',
                            icon: Icons.alternate_email,
                          ),
                        ),

                        const SizedBox(height: 18),

                        // =====================================
                        // PASSWORD
                        // =====================================
                        const Text(
                          'Password',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.darkPlum,
                          ),
                        ),

                        const SizedBox(height: 8),

                        TextField(
                          controller: passwordController,
                          obscureText: !isPasswordVisible,
                          textInputAction: TextInputAction.done,
                          onSubmitted: (_) {
                            if (!isLoading) {
                              login();
                            }
                          },
                          decoration:
                              _inputDecoration(
                                hint: 'Masukkan password',
                                icon: Icons.lock_outline,
                              ).copyWith(
                                suffixIcon: IconButton(
                                  tooltip: isPasswordVisible
                                      ? 'Sembunyikan password'
                                      : 'Tampilkan password',
                                  onPressed: () {
                                    setState(() {
                                      isPasswordVisible = !isPasswordVisible;
                                    });
                                  },
                                  icon: Icon(
                                    isPasswordVisible
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: AppTheme.dustyRoseDark,
                                  ),
                                ),
                              ),
                        ),

                        const SizedBox(height: 12),

                        // =====================================
                        // REMEMBER + FORGOT
                        // =====================================
                        Row(
                          children: [
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: Checkbox(
                                value: rememberMe,
                                activeColor: AppTheme.darkPlum,
                                checkColor: AppTheme.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    rememberMe = value ?? false;
                                  });
                                },
                              ),
                            ),

                            const SizedBox(width: 7),

                            const Text(
                              'Remember me',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppTheme.darkPlum,
                              ),
                            ),

                            const Spacer(),

                            TextButton(
                              onPressed: _showForgotPassword,
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: const Text(
                                'Forgot password?',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: AppTheme.dustyRoseDark,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // =====================================
                        // LOGIN BUTTON
                        // =====================================
                        SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: FilledButton(
                            onPressed: isLoading ? null : login,
                            style: FilledButton.styleFrom(
                              backgroundColor: AppTheme.darkPlum,
                              disabledBackgroundColor: AppTheme.darkPlum
                                  .withValues(alpha: 0.55),
                              foregroundColor: AppTheme.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(17),
                              ),
                              elevation: 0,
                            ),
                            child: isLoading
                                ? const SizedBox(
                                    width: 22,
                                    height: 22,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      color: AppTheme.white,
                                    ),
                                  )
                                : const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Masuk ke Mochié',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Icon(
                                        Icons.arrow_forward_rounded,
                                        size: 19,
                                      ),
                                    ],
                                  ),
                          ),
                        ),

                        const SizedBox(height: 18),

                        // =====================================
                        // DIVIDER
                        // =====================================
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: AppTheme.dustyRose.withValues(
                                  alpha: 0.7,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              child: Text(
                                'atau',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: AppTheme.darkPlum.withValues(
                                    alpha: 0.45,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: AppTheme.dustyRose.withValues(
                                  alpha: 0.7,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 15),

                        // =====================================
                        // GUEST
                        // =====================================
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: OutlinedButton(
                            onPressed: _continueAsGuest,
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppTheme.darkPlum,
                              side: BorderSide(
                                color: AppTheme.dustyRoseDark.withValues(
                                  alpha: 0.35,
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(17),
                              ),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.person_outline_rounded, size: 19),
                                SizedBox(width: 8),
                                Text(
                                  'Lanjut sebagai tamu',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ===========================================
                  // FOOTER
                  // ===========================================
                  Center(
                    child: Text(
                      'Made with sweetness • MOCHIÉ 🍓',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppTheme.darkPlum.withValues(alpha: 0.45),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // INPUT DECORATION
  // =========================================================

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        color: AppTheme.darkPlum.withValues(alpha: 0.35),
        fontSize: 13,
      ),
      prefixIcon: Icon(icon, color: AppTheme.dustyRoseDark, size: 20),
      filled: true,
      fillColor: AppTheme.cream,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(17),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(17),
        borderSide: BorderSide(
          color: AppTheme.dustyRose.withValues(alpha: 0.35),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(17),
        borderSide: const BorderSide(color: AppTheme.dustyRoseDark, width: 1.5),
      ),
    );
  }
}
