import 'package:flutter/material.dart';

import '../app_data.dart';
import '../models/mochi.dart';
import '../theme/app_theme.dart';
import 'mochi_detail_page.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

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

  Future<void> _removeFavorite(
    BuildContext context,
    Map<String, dynamic> mochi,
  ) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppTheme.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          title: const Text(
            'Hapus dari Favorite?',
            style: TextStyle(
              color: AppTheme.darkPlum,
              fontWeight: FontWeight.w800,
            ),
          ),
          content: Text(
            '${mochi['name']} akan dihapus dari daftar favorite.',
            style: const TextStyle(color: AppTheme.darkPlum, height: 1.5),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text(
                'BATAL',
                style: TextStyle(
                  color: AppTheme.dustyRoseDark,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.darkPlum,
                foregroundColor: AppTheme.white,
              ),
              child: const Text(
                'HAPUS',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ],
        );
      },
    );

    if (result == true) {
      AppData.toggleFavorite(mochi);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${mochi['name']} dihapus dari favorite'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: AppTheme.darkPlum,
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  void _addToCart(BuildContext context, Map<String, dynamic> mochi) {
    AppData.addToCart(mochi);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_outline, color: AppTheme.white),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                '${mochi['name']} ditambahkan ke cart',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppTheme.darkPlum,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Widget _rating(double rating) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: AppTheme.softPink,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.star_rounded,
            size: 16,
            color: AppTheme.dustyRoseDark,
          ),
          const SizedBox(width: 3),
          Text(
            rating.toString(),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: AppTheme.darkPlum,
            ),
          ),
        ],
      ),
    );
  }

  Widget _favoriteCard(BuildContext context, Map<String, dynamic> mochi) {
    final rating = (mochi['rating'] as num).toDouble();

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppTheme.darkPlum.withValues(alpha: 0.06),
            blurRadius: 18,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
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
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                // IMAGE
                Hero(
                  tag: 'favorite-${mochi['name']}',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Image.asset(
                      mochi['image'],
                      width: 105,
                      height: 105,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                const SizedBox(width: 14),

                // CONTENT
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
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: AppTheme.darkPlum,
                              ),
                            ),
                          ),

                          IconButton(
                            onPressed: () {
                              _removeFavorite(context, mochi);
                            },
                            icon: const Icon(
                              Icons.favorite_rounded,
                              color: AppTheme.dustyRoseDark,
                            ),
                            tooltip: 'Hapus favorite',
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),

                      const SizedBox(height: 4),

                      Text(
                        mochi['description'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppTheme.darkPlum,
                          height: 1.4,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Row(
                        children: [
                          _rating(rating),
                          const Spacer(),
                          Text(
                            _formatRupiah(mochi['price']),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                              color: AppTheme.darkPlum,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      SizedBox(
                        width: double.infinity,
                        height: 38,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            _addToCart(context, mochi);
                          },
                          icon: const Icon(
                            Icons.shopping_bag_outlined,
                            size: 17,
                          ),
                          label: const Text(
                            'TAMBAH KE CART',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.darkPlum,
                            foregroundColor: AppTheme.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
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

  Widget _emptyFavorite(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon Love
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppTheme.softPink,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.favorite_border_rounded,
                size: 48,
                color: AppTheme.dustyRoseDark,
              ),
            ),

            const SizedBox(height: 24),

            // Judul
            const Text(
              'Belum Ada Favorit',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: AppTheme.darkPlum,
              ),
            ),

            const SizedBox(height: 10),

            // Deskripsi
            const Text(
              'Yuk pilih mochi favoritmu\n'
              'dan simpan di sini ♡',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color: Colors.black54,
              ),
            ),

            const SizedBox(height: 28),

            // Tombol kembali eksplorasi
            ElevatedButton.icon(
              onPressed: () {},

              icon: const Icon(Icons.explore_outlined, size: 20),
              label: const Text('Mulai Eksplorasi'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.darkPlum,
                foregroundColor: AppTheme.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header(int count) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 18),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppTheme.softPink, AppTheme.dustyRose],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: const BoxDecoration(
              color: AppTheme.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.favorite_rounded,
              color: AppTheme.dustyRoseDark,
              size: 27,
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
                    fontSize: 19,
                    fontWeight: FontWeight.w900,
                    color: AppTheme.darkPlum,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  '$count mochi tersimpan',
                  style: const TextStyle(
                    fontSize: 12,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.cream,
      appBar: AppBar(
        title: const Text(
          'Favorite',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
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
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
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
