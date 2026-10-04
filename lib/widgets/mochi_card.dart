import 'package:flutter/material.dart';

import '../app_data.dart';
import '../theme/app_theme.dart';

class MochiCard extends StatelessWidget {
  final Map<String, dynamic> mochi;
  final VoidCallback onDetail;
  final VoidCallback? onFavoriteChanged;

  const MochiCard({
    super.key,
    required this.mochi,
    required this.onDetail,
    this.onFavoriteChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Map<String, dynamic>>>(
      valueListenable: AppData.favorites,
      builder: (context, favorites, child) {
        final isFavorite = favorites.any(
          (item) => item['name'] == mochi['name'],
        );

        return Container(
          width: 210,
          decoration: BoxDecoration(
            color: AppTheme.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: AppTheme.dustyRoseDark.withValues(alpha: 0.10),
                blurRadius: 15,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // =====================================================
              // GAMBAR + TOMBOL FAVORITE
              // =====================================================

              Padding(
                padding: const EdgeInsets.all(6),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(19),
                      child: SizedBox(
                        width: double.infinity,
                        height: 155,
                        child: Image.asset(
                          mochi['image'],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: AppTheme.softPink,
                              child: const Center(
                                child: Icon(
                                  Icons.image_not_supported_outlined,
                                  color: AppTheme.dustyRoseDark,
                                  size: 35,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    // =================================================
                    // FAVORITE BUTTON
                    // =================================================
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Material(
                        color: AppTheme.white,
                        shape: const CircleBorder(),
                        elevation: 2,
                        child: InkWell(
                          customBorder: const CircleBorder(),
                          onTap: () {
                            AppData.toggleFavorite(mochi);

                            if (onFavoriteChanged != null) {
                              onFavoriteChanged!();
                            }
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isFavorite
                                  ? AppTheme.softPink
                                  : AppTheme.white,
                            ),
                            child: Icon(
                              isFavorite
                                  ? Icons.favorite_rounded
                                  : Icons.favorite_border_rounded,
                              size: 21,
                              color: AppTheme.dustyRoseDark,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // =====================================================
              // INFORMASI MOCHI
              // =====================================================
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 9),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mochi['name'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.darkPlum,
                      ),
                    ),

                    const SizedBox(height: 4),

                    // Rating
                    Row(
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          size: 18,
                          color: AppTheme.dustyRoseDark,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          mochi['rating'].toString(),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.darkPlum.withValues(alpha: 0.55),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 5),

                    // Deskripsi
                    SizedBox(
                      height: 42,
                      child: Text(
                        mochi['description'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 11.5,
                          height: 1.4,
                          color: AppTheme.darkPlum.withValues(alpha: 0.48),
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    // =================================================
                    // HARGA + DETAIL
                    // =================================================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          mochi['price'],
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.dustyRoseDark,
                          ),
                        ),

                        SizedBox(
                          height: 35,
                          child: ElevatedButton(
                            onPressed: onDetail,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.darkPlum,
                              foregroundColor: AppTheme.white,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13),
                              ),
                            ),
                            child: const Text(
                              'Detail',
                              style: TextStyle(
                                fontSize: 10.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
