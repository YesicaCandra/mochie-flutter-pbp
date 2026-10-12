import 'package:flutter/material.dart';

// Titik pecah lebar layar untuk seluruh aplikasi.
class Breakpoints {
  // Mulai dari sini daftar produk memakai grid, bukan satu kolom.
  static const double grid = 600;

  // Mulai dari sini header satu baris dan chip rasa berbentuk wrap.
  static const double medium = 720;

  // Mulai dari sini navigasi pindah ke rail di kiri.
  static const double wide = 840;

  // Lebar konten maksimum agar tidak terlalu melebar di monitor besar.
  static const double maxContent = 1240;
}

// Memusatkan konten dan membatasi lebarnya di layar lebar.
// Di layar kecil, konten tetap memenuhi lebar layar.
class ResponsiveCenter extends StatelessWidget {
  final Widget child;
  final double maxWidth;

  const ResponsiveCenter({super.key, required this.child, this.maxWidth = 720});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}
