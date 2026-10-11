import 'package:flutter/material.dart';

import '../app_data.dart';
import '../models/mochi.dart';
import '../theme/app_theme.dart';
import '../widgets/app_snackbar.dart';
import '../widgets/mochi_image.dart';
import 'mochi_detail_page.dart';

class FavoritePage extends StatelessWidget {
  // Dipanggil tombol "Mulai Eksplorasi" untuk kembali ke tab Home.
  final VoidCallback? onExplore;

  const FavoritePage({super.key, this.onExplore});

  String _formatRupiah(String price) {
    final number = price
        .replaceAll('Rp', '')
        .replaceAll('.', '')
        .replaceAll(',', '')
        .trim();

    final value = int.tryParse(number) ?? 0;

    final formatted = value.toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (match) => '${match.group(1)}.',
    );

    return 'Rp$formatted';
  }

  // =========================================================
  // HAPUS FAVORIT (dengan konfirmasi)
  // =========================================================

  Future<void> _removeFavorite(
    BuildContext context,
    Map<String, dynamic> mochi,
  ) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Hapus dari Favorite?'),
          content: Text('${mochi['name']} akan dihapus dari daftar favorite.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('BATAL'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              child: const Text('HAPUS'),
            ),
          ],
        );
      },
    );

    if (result == true) {
      AppData.toggleFavorite(mochi);

      if (context.mounted) {
        AppSnackBar.show(
          context,
          '${mochi['name']} dihapus dari favorite',
          icon: Icons.heart_broken_outlined,
        );
      }
    }
  }

  // =========================================================
  // TAMBAH KE CART
  // =========================================================

  void _addToCart(BuildContext context, Map<String, dynamic> mochi) {
    AppData.addToCart(mochi);

    AppSnackBar.success(context, '${mochi['name']} ditambahkan ke cart');
  }

  // =========================================================
  // KARTU FAVORIT
  // =========================================================

  Widget _favoriteCard(BuildContext context, Map<String, dynamic> mochi) {
    final rating = (mochi['rating'] as num).toDouble();

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: AppTheme.cocoa.withValues(alpha: 0.07),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    MochiDetailPage(mochi: Mochi.fromMap(mochi)),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                MochiImage(
                  path: mochi['image'].toString(),
                  width: 96,
                  height: 118,
                  borderRadius: 16,
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              mochi['name'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontFamily: AppTheme.fontDisplay,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.cocoa,
                              ),
                            ),
                          ),

                          InkWell(
                            onTap: () {
                              _removeFavorite(context, mochi);
                            },
                            borderRadius: BorderRadius.circular(20),
                            child: const Padding(
                              padding: EdgeInsets.all(4),
                              child: Icon(
                                Icons.favorite_rounded,
                                size: 22,
                                color: AppTheme.primaryDeep,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 2),

                      Text(
                        mochi['description'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          height: 1.35,
                          color: AppTheme.cocoa.withValues(alpha: 0.8),
                        ),
                      ),

                      const SizedBox(height: 8),

                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.yellow,
                              borderRadius: BorderRadius.circular(9),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.star_rounded,
                                  size: 13,
                                  color: AppTheme.cocoa,
                                ),
                                const SizedBox(width: 3),
                                Text(
                                  rating.toString(),
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800,
                                    color: AppTheme.cocoa,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const Spacer(),

                          Text(
                            _formatRupiah(mochi['price']),
                            style: const TextStyle(
                              fontFamily: AppTheme.fontDisplay,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.primaryDeep,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      SizedBox(
                        width: double.infinity,
                        height: 36,
                        child: ElevatedButton(
                          onPressed: () {
                            _addToCart(context, mochi);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primary,
                            minimumSize: Size.zero,
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'TAMBAH KE CART',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ],
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
  // KOSONG
  // =========================================================

  Widget _emptyFavorite(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: AppTheme.softPink,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.favorite_border_rounded,
                size: 48,
                color: AppTheme.primary,
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Belum Ada Favorit',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: AppTheme.fontDisplay,
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: AppTheme.cocoa,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              'Yuk pilih mochi favoritmu\n'
              'dan simpan di sini ♡',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color: AppTheme.cocoa.withValues(alpha: 0.8),
              ),
            ),

            const SizedBox(height: 28),

            ElevatedButton.icon(
              onPressed: onExplore,
              icon: const Icon(Icons.explore_outlined, size: 20),
              label: const Text('Mulai Eksplorasi'),
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // HEADER
  // =========================================================

  Widget _header(int count) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 8, 20, 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppTheme.primaryDeep, AppTheme.primary],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: AppTheme.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.favorite_rounded,
              color: AppTheme.primaryDeep,
              size: 24,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Mochi Favoritku',
                  style: TextStyle(
                    fontFamily: AppTheme.fontDisplay,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.white,
                  ),
                ),

                Text(
                  '$count mochi tersimpan',
                  style: const TextStyle(
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
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.cream,
      appBar: AppBar(title: const Text('Favorite')),
      body: ValueListenableBuilder<List<Map<String, dynamic>>>(
        valueListenable: AppData.favorites,
        builder: (context, favorites, child) {
          if (favorites.isEmpty) {
            return _emptyFavorite(context);
          }

          return Column(
            children: [
              _header(favorites.length),

              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {
                    return _favoriteCard(context, favorites[index]);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
