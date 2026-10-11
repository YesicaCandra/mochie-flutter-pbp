import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

// Gambar produk dengan sudut membulat dan placeholder
// jika gambar gagal dimuat.
class MochiImage extends StatelessWidget {
  final String path;
  final double? width;
  final double? height;
  final double borderRadius;
  final BoxFit fit;
  final Alignment alignment;

  const MochiImage({
    super.key,
    required this.path,
    this.width,
    this.height,
    this.borderRadius = 16,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: SizedBox(
        width: width,
        height: height,
        child: Image.asset(
          path,
          fit: fit,
          alignment: alignment,
          gaplessPlayback: true,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: AppTheme.softPink,
              alignment: Alignment.center,
              child: const Icon(
                Icons.image_not_supported_outlined,
                color: AppTheme.primary,
                size: 32,
              ),
            );
          },
        ),
      ),
    );
  }
}
