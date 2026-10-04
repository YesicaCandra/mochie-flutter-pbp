import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../theme/app_theme.dart';
import 'login_page.dart';
import 'order_history_page.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  // =========================================================
  // PROFILE PHOTO
  // =========================================================

  Uint8List? _profileImageBytes;

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

      setState(() {
        _profileImageBytes = imageBytes;
      });
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Foto profil gagal dipilih.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.cream,

      // =======================================================
      // APP BAR
      // =======================================================
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'About MOCHIÉ',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppTheme.darkPlum,
          ),
        ),
      ),

      // =======================================================
      // BODY
      // =======================================================
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===================================================
            // HEADER MOCHIÉ
            // ===================================================

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppTheme.softPink,
                    AppTheme.dustyRose,
                    AppTheme.cream,
                  ],
                ),
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.dustyRoseDark.withValues(alpha: 0.12),
                    blurRadius: 18,
                    offset: const Offset(0, 7),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // =================================================
                  // ICON MOCHIÉ
                  // =================================================

                  Container(
                    width: 82,
                    height: 82,
                    decoration: BoxDecoration(
                      color: AppTheme.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.dustyRoseDark.withValues(alpha: 0.15),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text('🍡', style: TextStyle(fontSize: 42)),
                    ),
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    'MOCHIÉ',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      color: AppTheme.darkPlum,
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    'Sweet moments, one mochi at a time.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                      color: AppTheme.darkPlum,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // ===================================================
            // ABOUT APP
            // ===================================================
            const Text(
              'Tentang Aplikasi',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.darkPlum,
              ),
            ),

            const SizedBox(height: 12),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(19),
              decoration: BoxDecoration(
                color: AppTheme.white,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.dustyRoseDark.withValues(alpha: 0.07),
                    blurRadius: 15,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'MOCHIÉ adalah aplikasi sederhana untuk '
                    'menjelajahi berbagai pilihan mochi favorit.',
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.6,
                      color: Colors.black54,
                    ),
                  ),

                  SizedBox(height: 12),

                  Text(
                    'Di dalam aplikasi ini kamu dapat melihat '
                    'detail mochi, menambahkan produk ke favorit, '
                    'memasukkan produk ke keranjang, melakukan '
                    'checkout, dan melihat riwayat pesanan.',
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.6,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // ===================================================
            // ABOUT ME
            // ===================================================
            const Text(
              'About Me',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.darkPlum,
              ),
            ),

            const SizedBox(height: 12),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.white,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.dustyRoseDark.withValues(alpha: 0.07),
                    blurRadius: 15,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // =================================================
                  // PROFILE PHOTO
                  // =================================================

                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // FOTO PROFIL
                      Container(
                        width: 92,
                        height: 92,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [AppTheme.dustyRose, AppTheme.softPink],
                          ),
                          border: Border.all(color: AppTheme.white, width: 4),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.dustyRoseDark.withValues(
                                alpha: 0.18,
                              ),
                              blurRadius: 15,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: _profileImageBytes != null
                              ? Image.memory(
                                  _profileImageBytes!,
                                  width: 92,
                                  height: 92,
                                  fit: BoxFit.cover,
                                )
                              : const Center(
                                  child: Icon(
                                    Icons.person_outline,
                                    size: 45,
                                    color: AppTheme.darkPlum,
                                  ),
                                ),
                        ),
                      ),

                      // =================================================
                      // TOMBOL KAMERA
                      // =================================================
                      Positioned(
                        right: -2,
                        bottom: -2,
                        child: Material(
                          color: AppTheme.darkPlum,
                          shape: const CircleBorder(),
                          elevation: 3,
                          child: InkWell(
                            onTap: _pickProfilePhoto,
                            customBorder: const CircleBorder(),
                            child: const SizedBox(
                              width: 34,
                              height: 34,
                              child: Center(
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  size: 18,
                                  color: AppTheme.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // =================================================
                  // TOMBOL GANTI FOTO
                  // =================================================
                  TextButton.icon(
                    onPressed: _pickProfilePhoto,
                    icon: const Icon(Icons.photo_camera_outlined, size: 17),
                    label: const Text('Ganti foto profil'),
                    style: TextButton.styleFrom(
                      foregroundColor: AppTheme.dustyRoseDark,
                      textStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(height: 4),

                  // =================================================
                  // NAME
                  // =================================================
                  const Text(
                    'Yesica Candra Carlota',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.darkPlum,
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    'Mahasiswa S1 Teknik Informatika',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13, color: Colors.black54),
                  ),

                  const SizedBox(height: 20),

                  // =================================================
                  // DATA PROFILE
                  // =================================================
                  _InfoRow(
                    icon: Icons.location_on_outlined,
                    title: 'Asal',
                    value: 'Wonogiri',
                  ),

                  const SizedBox(height: 12),

                  _InfoRow(
                    icon: Icons.school_outlined,
                    title: 'Program',
                    value: 'S1 Teknik Informatika',
                  ),

                  const SizedBox(height: 12),

                  _InfoRow(
                    icon: Icons.menu_book_outlined,
                    title: 'Semester',
                    value: 'Semester 3',
                  ),

                  const SizedBox(height: 12),

                  _InfoRow(
                    icon: Icons.account_balance_outlined,
                    title: 'Universitas',
                    value: 'Universitas Negeri Surabaya',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // ===================================================
            // ORDER HISTORY
            // ===================================================
            const Text(
              'Pesanan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.darkPlum,
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OrderHistoryPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.receipt_long_outlined),
                label: const Text('Order History'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.darkPlum,
                  foregroundColor: AppTheme.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 17),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ===================================================
            // LOGOUT
            // ===================================================
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  _showLogoutDialog(context);
                },
                icon: const Icon(Icons.logout_outlined),
                label: const Text('Logout'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppTheme.darkPlum,
                  side: const BorderSide(
                    color: AppTheme.dustyRoseDark,
                    width: 1.2,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 17),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            // ===================================================
            // FOOTER
            // ===================================================
            const Center(
              child: Text(
                'MOCHIÉ • Made with ♡',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black38,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================
  // LOGOUT DIALOG
  // ===========================================================

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppTheme.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          title: const Row(
            children: [
              Icon(Icons.logout_outlined, color: AppTheme.dustyRoseDark),
              SizedBox(width: 10),
              Text(
                'Logout',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.darkPlum,
                ),
              ),
            ],
          ),
          content: const Text(
            'Apakah kamu yakin ingin keluar dari aplikasi?',
            style: TextStyle(fontSize: 14, height: 1.5, color: Colors.black54),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text(
                'Batal',
                style: TextStyle(color: Colors.black54),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.darkPlum,
                foregroundColor: AppTheme.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}

// =============================================================
// INFO ROW
// =============================================================

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppTheme.cream,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppTheme.softPink,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 20, color: AppTheme.darkPlum),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 11, color: Colors.black45),
                ),

                const SizedBox(height: 2),

                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.darkPlum,
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
