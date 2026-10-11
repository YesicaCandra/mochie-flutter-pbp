import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/mochi_image.dart';

// Halaman tentang aplikasi Mochié.
// Dibuka dari menu "Tentang Mochié" di halaman Profile.
// Data pembuat (About Me) ada di halaman Profile.
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  TextStyle _sectionStyle() {
    return const TextStyle(
      fontFamily: AppTheme.fontDisplay,
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: AppTheme.cocoa,
    );
  }

  // =========================================================
  // KARTU BRAND
  // =========================================================

  Widget _buildBrandCard() {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppTheme.primaryDeep, AppTheme.primary],
        ),
        borderRadius: BorderRadius.circular(26),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -50,
            right: -40,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppTheme.peach.withValues(alpha: 0.5),
                shape: BoxShape.circle,
              ),
            ),
          ),

          Center(
            child: Column(
              children: [
                Container(
                  width: 68,
                  height: 68,
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: AppTheme.white,
                    shape: BoxShape.circle,
                  ),
                  child: const MochiImage(
                    path: 'assets/images/mochie_logo.png',
                    borderRadius: 34,
                    fit: BoxFit.contain,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'MOCHIÉ',
                  style: TextStyle(
                    fontFamily: AppTheme.fontDisplay,
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2,
                    color: AppTheme.white,
                  ),
                ),

                const SizedBox(height: 2),

                const Text(
                  'Sweet moments, one mochi at a time.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // KARTU TENTANG APLIKASI
  // =========================================================

  Widget _buildAppInfoCard() {
    final style = TextStyle(
      fontSize: 13,
      height: 1.55,
      fontWeight: FontWeight.w600,
      color: AppTheme.cocoa.withValues(alpha: 0.9),
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppTheme.cocoa.withValues(alpha: 0.05),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'MOCHIÉ adalah aplikasi sederhana untuk '
            'menjelajahi berbagai pilihan mochi favorit.',
            style: style,
          ),

          const SizedBox(height: 10),

          Text(
            'Di dalam aplikasi ini kamu dapat melihat '
            'detail mochi, menambahkan produk ke favorit, '
            'memasukkan produk ke keranjang, melakukan '
            'checkout, dan melihat riwayat pesanan.',
            style: style,
          ),
        ],
      ),
    );
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.cream,
      appBar: AppBar(title: const Text('About MOCHIÉ')),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBrandCard(),

            const SizedBox(height: 20),

            Text('Tentang Aplikasi', style: _sectionStyle()),

            const SizedBox(height: 8),

            _buildAppInfoCard(),

            const SizedBox(height: 24),

            Center(
              child: Text(
                'MOCHIÉ • Made with ♡',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.cocoa.withValues(alpha: 0.75),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
