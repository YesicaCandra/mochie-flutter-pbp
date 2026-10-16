import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../app_data.dart';
import '../theme/app_theme.dart';
import '../widgets/app_snackbar.dart';
import '../widgets/responsive.dart';
import 'about_page.dart';
import 'cart_page.dart';
import 'login_page.dart';
import 'order_history_page.dart';

class ProfilePage extends StatefulWidget {
  // Dipakai menu "Favorit Saya" untuk pindah ke tab Favorite di Home.
  final ValueChanged<int>? onSelectTab;

  const ProfilePage({super.key, this.onSelectTab});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ImagePicker _imagePicker = ImagePicker();

  // =========================================================
  // PILIH FOTO PROFIL
  // =========================================================

  Future<void> _pickProfilePhoto() async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (pickedFile == null) {
        return;
      }

      final Uint8List imageBytes = await pickedFile.readAsBytes();

      if (!mounted) return;

      AppData.profilePhoto.value = imageBytes;
    } catch (e) {
      if (!mounted) return;

      AppSnackBar.error(context, 'Foto profil gagal dipilih.');
    }
  }

  TextStyle _sectionStyle() {
    return const TextStyle(
      fontFamily: AppTheme.fontDisplay,
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: AppTheme.cocoa,
    );
  }

  // =========================================================
  // AVATAR
  // =========================================================

  Widget _buildAvatar() {
    return SizedBox(
      width: 92,
      height: 92,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              color: AppTheme.white,
              shape: BoxShape.circle,
              border: Border.all(color: AppTheme.yellow, width: 4),
            ),
            child: ClipOval(
              child: ValueListenableBuilder<Uint8List?>(
                valueListenable: AppData.profilePhoto,
                builder: (context, bytes, child) {
                  if (bytes != null) {
                    return Image.memory(
                      bytes,
                      width: 88,
                      height: 88,
                      fit: BoxFit.cover,
                    );
                  }

                  return const Icon(
                    Icons.person_outline_rounded,
                    size: 42,
                    color: AppTheme.primaryDeep,
                  );
                },
              ),
            ),
          ),

          Positioned(
            right: -2,
            bottom: 0,
            child: Material(
              color: AppTheme.yellow,
              shape: const CircleBorder(),
              child: InkWell(
                onTap: _pickProfilePhoto,
                customBorder: const CircleBorder(),
                child: const SizedBox(
                  width: 32,
                  height: 32,
                  child: Icon(
                    Icons.camera_alt_outlined,
                    size: 17,
                    color: AppTheme.cocoa,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // KARTU HEADER (foto + nama)
  // =========================================================

  Widget _buildHeaderCard() {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppTheme.primaryDeep, AppTheme.primary],
        ),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -52,
            right: -42,
            child: Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                color: AppTheme.peach.withValues(alpha: 0.5),
                shape: BoxShape.circle,
              ),
            ),
          ),

          Center(
            child: Column(
              children: [
                _buildAvatar(),

                const SizedBox(height: 12),

                const Text(
                  'Yesica Candra Carlota',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: AppTheme.fontDisplay,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.white,
                  ),
                ),

                const SizedBox(height: 2),

                const Text(
                  'Mahasiswa S1 Teknik Informatika',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.white,
                  ),
                ),

                const SizedBox(height: 10),

                Material(
                  color: AppTheme.yellow,
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                    onTap: _pickProfilePhoto,
                    borderRadius: BorderRadius.circular(12),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      child: Text(
                        'Ganti foto profil',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: AppTheme.cocoa,
                        ),
                      ),
                    ),
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
  // KARTU ABOUT ME
  // =========================================================

  Widget _buildAboutMeCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 6, 14, 14),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppTheme.cocoa.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: const Column(
        children: [
          _InfoRow(
            icon: Icons.location_on_outlined,
            color: AppTheme.dustyRose,
            title: 'Asal',
            value: 'Wonogiri',
          ),

          _InfoRow(
            icon: Icons.school_outlined,
            color: AppTheme.lavender,
            title: 'Program',
            value: 'S1 Teknik Informatika',
          ),

          _InfoRow(
            icon: Icons.menu_book_outlined,
            color: AppTheme.yellow,
            title: 'Semester',
            value: 'Semester 3',
          ),

          _InfoRow(
            icon: Icons.account_balance_outlined,
            color: AppTheme.mint,
            title: 'Universitas',
            value: 'Universitas Negeri Surabaya',
          ),
        ],
      ),
    );
  }

  // =========================================================
  // MENU
  // =========================================================

  Widget _menuRow({
    required IconData icon,
    required Color color,
    required String label,
    required VoidCallback onTap,
    bool showDivider = true,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(icon, size: 20, color: AppTheme.cocoa),
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: Text(
                    label,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: AppTheme.cocoa,
                    ),
                  ),
                ),

                const Icon(Icons.chevron_right_rounded, color: AppTheme.cocoa),
              ],
            ),
          ),
        ),

        if (showDivider)
          const Divider(height: 1, thickness: 1, color: AppTheme.softPink),
      ],
    );
  }

  Widget _buildMenuCard() {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppTheme.cocoa.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: Column(
          children: [
            _menuRow(
              icon: Icons.receipt_long_outlined,
              color: AppTheme.lavender,
              label: 'Order History',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OrderHistoryPage(),
                  ),
                );
              },
            ),

            _menuRow(
              icon: Icons.favorite_border_rounded,
              color: AppTheme.dustyRose,
              label: 'Favorit Saya',
              onTap: () {
                widget.onSelectTab?.call(1);
              },
            ),

            _menuRow(
              icon: Icons.shopping_bag_outlined,
              color: const Color(0xFFFFB98F),
              label: 'Keranjang',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartPage()),
                );
              },
            ),

            _menuRow(
              icon: Icons.info_outline_rounded,
              color: AppTheme.mint,
              label: 'Tentang Mochié',
              showDivider: false,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutPage()),
                );
              },
            ),
          ],
        ),
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
      body: SafeArea(
        child: ResponsiveCenter(
          maxWidth: 720,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Profile',
                  style: TextStyle(
                    fontFamily: AppTheme.fontDisplay,
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.cocoa,
                  ),
                ),

                const SizedBox(height: 16),

                _buildHeaderCard(),

                const SizedBox(height: 20),

                Text('About Me', style: _sectionStyle()),

                const SizedBox(height: 8),

                _buildAboutMeCard(),

                const SizedBox(height: 20),

                _buildMenuCard(),

                const SizedBox(height: 18),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      _showLogoutDialog(context);
                    },
                    icon: const Icon(Icons.logout_outlined),
                    label: const Text('Logout'),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                Center(
                  child: Text(
                    'Mochié • Made with love',
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
        ),
      ),
    );
  }

  // =========================================================
  // LOGOUT DIALOG (logika sama seperti sebelumnya)
  // =========================================================

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.logout_outlined, color: AppTheme.primaryDeep),
              SizedBox(width: 10),
              Text('Logout'),
            ],
          ),
          content: const Text('Apakah kamu yakin ingin keluar dari aplikasi?'),
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
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);

                // Bersihkan data sesi: keranjang, favorit, riwayat, foto.
                AppData.clearAll();

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (route) => false,
                );
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}

// =============================================================
// BARIS INFO (About Me)
// =============================================================

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.color,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        color: AppTheme.cream,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 19, color: AppTheme.cocoa),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.cocoa.withValues(alpha: 0.8),
                  ),
                ),

                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.cocoa,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
