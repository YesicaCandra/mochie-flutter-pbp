import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/animated_mochi_background.dart';
import '../widgets/app_snackbar.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/gradient_button.dart';
import '../widgets/mochi_image.dart';
import 'home_page.dart';
import 'register_page.dart';

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
  // LOGIN (validasi dan alur sama seperti sebelumnya)
  // =========================================================

  Future<void> login() async {
    FocusScope.of(context).unfocus();

    final String email = emailController.text.trim();

    final String password = passwordController.text.trim();

    // VALIDASI EMAIL
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

    // VALIDASI PASSWORD
    if (password.isEmpty) {
      _showMessage('Password belum diisi.', Icons.lock_outline);
      return;
    }

    if (password.length < 6) {
      _showMessage('Password minimal 6 karakter.', Icons.lock_outline);
      return;
    }

    // LOADING
    setState(() {
      isLoading = true;
    });

    // Simulasi proses login.
    await Future.delayed(const Duration(milliseconds: 900));

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });

    // MASUK KE HOME
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email);
  }

  void _showMessage(String message, IconData icon) {
    AppSnackBar.show(context, message, icon: icon);
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
          title: const Text('Forgot Password?'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Masukkan email kamu. Fitur reset password dapat digunakan setelah aplikasi terhubung ke sistem akun.',
                style: TextStyle(
                  color: AppTheme.cocoa.withValues(alpha: 0.8),
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 18),

              TextField(
                controller: forgotController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'Email kamu',
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: AppTheme.primaryDeep,
                  ),
                  fillColor: AppTheme.cream,
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
                style: TextStyle(color: AppTheme.cocoa),
              ),
            ),
            FilledButton(
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

  void _openRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterPage()),
    );
  }

  // =========================================================
  // BAGIAN-BAGIAN TAMPILAN
  // =========================================================

  // Tanda merek kecil (logo) di kartu pada layout lebar.
  Widget _buildBrandRow() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const MochiImage(
              path: 'assets/images/mochie_logo.png',
              borderRadius: 10,
              fit: BoxFit.contain,
            ),
          ),

          const SizedBox(width: 10),

          const Text(
            'Mochié',
            style: TextStyle(
              fontFamily: AppTheme.fontDisplay,
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: AppTheme.primaryDeep,
            ),
          ),
        ],
      ),
    );
  }

  // Kartu login (kaca semi-transparan).
  Widget _buildCard({bool showBrand = false}) {
    return ClipRRect(
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
                color: AppTheme.primary.withValues(alpha: 0.16),
                blurRadius: 28,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showBrand) _buildBrandRow(),

              CustomTextField(
                label: 'Email',
                hint: 'nama@email.com',
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),

              const SizedBox(height: 14),

              CustomTextField(
                label: 'Password',
                hint: 'Masukkan password',
                controller: passwordController,
                obscureText: !isPasswordVisible,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) {
                  if (!isLoading) {
                    login();
                  }
                },
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
                    color: AppTheme.primaryDeep,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // REMEMBER + FORGOT
              Row(
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Checkbox(
                      value: rememberMe,
                      onChanged: (value) {
                        setState(() {
                          rememberMe = value ?? false;
                        });
                      },
                    ),
                  ),

                  const SizedBox(width: 8),

                  const Text(
                    'Remember me',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: AppTheme.cocoa,
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
                        fontWeight: FontWeight.w800,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                child: GradientButton(
                  label: 'Masuk ke Mochié',
                  trailingIcon: Icons.arrow_forward_rounded,
                  isLoading: isLoading,
                  onPressed: login,
                ),
              ),

              const SizedBox(height: 12),

              Center(
                child: Text(
                  'atau',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.cocoa.withValues(alpha: 0.75),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton(
                  onPressed: _continueAsGuest,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.cocoa,
                    backgroundColor: AppTheme.white,
                    side: const BorderSide(
                      color: AppTheme.dustyRose,
                      width: 1.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(17),
                    ),
                  ),
                  child: const Text('Lanjut sebagai tamu'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Belum punya akun? ',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: AppTheme.cocoa,
          ),
        ),

        TextButton(
          onPressed: _openRegister,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(0, 36),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: const Text(
            'Daftar',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  // =========================================================
  // LAYOUT VERTIKAL (ponsel portrait)
  // =========================================================

  Widget _buildNarrow() {
    // Saat keyboard terbuka, header disembunyikan agar form tetap terlihat.
    final keyboardOpen = MediaQuery.viewInsetsOf(context).bottom > 0;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
      child: Column(
        children: [
          if (!keyboardOpen) ...[
            Container(
              width: 76,
              height: 76,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppTheme.white,
                borderRadius: BorderRadius.circular(26),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primary.withValues(alpha: 0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const MochiImage(
                path: 'assets/images/mochie_logo.png',
                borderRadius: 18,
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Welcome',
              style: TextStyle(
                fontFamily: AppTheme.fontDisplay,
                fontSize: 40,
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
                color: AppTheme.primaryDeep,
              ),
            ),

            const Text(
              'Have a great journey ahead...',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.5,
                color: AppTheme.cocoa,
              ),
            ),

            const SizedBox(height: 22),
          ],

          _buildCard(),

          const SizedBox(height: 12),

          _buildRegisterLink(),
        ],
      ),
    );
  }

  // =========================================================
  // LAYOUT HORIZONTAL (landscape / tablet / browser lebar)
  // =========================================================

  Widget _buildWide() {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.only(left: 64, right: 24),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Welcome',
                    style: TextStyle(
                      fontFamily: AppTheme.fontDisplay,
                      fontSize: 72,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2,
                      height: 1,
                      color: AppTheme.primaryDeep,
                    ),
                  ),

                  SizedBox(height: 10),

                  Text(
                    'Have a great journey ahead...',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2,
                      color: AppTheme.cocoa,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        Expanded(
          flex: 4,
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildCard(showBrand: true),

                    const SizedBox(height: 12),

                    _buildRegisterLink(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.cream,
      body: AnimatedMochiBackground(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 720;

              return isWide ? _buildWide() : _buildNarrow();
            },
          ),
        ),
      ),
    );
  }
}
