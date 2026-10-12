import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../app_data.dart';
import '../models/mochi.dart';
import '../theme/app_theme.dart';
import '../widgets/app_snackbar.dart';
import '../widgets/gradient_button.dart';
import '../widgets/mochi_image.dart';
import '../widgets/responsive.dart';
import 'cart_page.dart';

class MochiDetailPage extends StatefulWidget {
  final Mochi mochi;

  const MochiDetailPage({super.key, required this.mochi});

  @override
  State<MochiDetailPage> createState() => _MochiDetailPageState();
}

class _MochiDetailPageState extends State<MochiDetailPage> {
  // Jumlah yang akan ditambahkan ke keranjang.
  int _quantity = 1;

  Mochi get mochi => widget.mochi;

  // =========================================================
  // HARGA
  // =========================================================

  double get _price {
    final priceText = mochi.price
        .replaceAll('Rp', '')
        .replaceAll('.', '')
        .replaceAll(',', '')
        .trim();

    return double.tryParse(priceText) ?? 0;
  }

  String _formatRupiah(double value) {
    final number = value.toInt().toString();

    final formatted = number.replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]}.',
    );

    return 'Rp$formatted';
  }

  // =========================================================
  // TAMBAH KE KERANJANG (logika sama seperti sebelumnya)
  // =========================================================

  void _addToCart() {
    final addedQuantity = _quantity;

    for (int i = 0; i < addedQuantity; i++) {
      AppData.addToCart(mochi.toMap());
    }

    setState(() {
      _quantity = 1;
    });

    AppSnackBar.show(
      context,
      '$addedQuantity ${mochi.name} berhasil ditambahkan ke keranjang',
      icon: Icons.check_circle_outline_rounded,
      duration: const Duration(seconds: 4),
      action: SnackBarAction(
        label: 'LIHAT CART',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CartPage()),
          );
        },
      ),
    );
  }

  // =========================================================
  // TOMBOL BULAT (kembali & favorit)
  // =========================================================

  Widget _roundButton({
    required Widget child,
    required VoidCallback onTap,
    required String tooltip,
  }) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: AppTheme.white,
        shape: const CircleBorder(),
        elevation: 2,
        shadowColor: AppTheme.cocoa.withValues(alpha: 0.2),
        child: InkWell(
          onTap: onTap,
          customBorder: const CircleBorder(),
          child: SizedBox(width: 44, height: 44, child: Center(child: child)),
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return _roundButton(
      tooltip: 'Kembali',
      onTap: () {
        Navigator.pop(context);
      },
      child: const Icon(
        Icons.arrow_back_ios_new_rounded,
        size: 18,
        color: AppTheme.cocoa,
      ),
    );
  }

  Widget _buildHeartButton() {
    return ValueListenableBuilder<List<Map<String, dynamic>>>(
      valueListenable: AppData.favorites,
      builder: (context, favorites, child) {
        final isFavorite = AppData.isFavorite(mochi.name);

        return _roundButton(
          tooltip: isFavorite ? 'Hapus dari favorit' : 'Tambah ke favorit',
          onTap: () {
            AppData.toggleFavorite(mochi.toMap());
          },
          child: Icon(
            isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
            size: 22,
            color: AppTheme.primaryDeep,
          ),
        );
      },
    );
  }

  // =========================================================
  // INFORMASI PRODUK (dipakai layar sempit dan lebar)
  // =========================================================

  Widget _buildInfoColumn(bool wide) {
    final description = mochi.detailDescription.isNotEmpty
        ? mochi.detailDescription
        : mochi.description;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          mochi.name,
          style: TextStyle(
            fontFamily: AppTheme.fontDisplay,
            fontSize: wide ? 40 : 28,
            fontWeight: FontWeight.w600,
            color: AppTheme.cocoa,
          ),
        ),

        const SizedBox(height: 8),

        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: AppTheme.yellow,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.star_rounded,
                    size: 16,
                    color: AppTheme.cocoa,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    mochi.rating.toString(),
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: AppTheme.cocoa,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 10),

            Text(
              'Favorit pelanggan',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppTheme.cocoa.withValues(alpha: 0.8),
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),

        Text(
          mochi.price,
          style: TextStyle(
            fontFamily: AppTheme.fontDisplay,
            fontSize: wide ? 34 : 26,
            fontWeight: FontWeight.w600,
            color: AppTheme.primaryDeep,
          ),
        ),

        SizedBox(height: wide ? 22 : 16),

        Text(
          'Tentang Mochi',
          style: TextStyle(
            fontFamily: AppTheme.fontDisplay,
            fontSize: wide ? 20 : 18,
            fontWeight: FontWeight.w600,
            color: AppTheme.cocoa,
          ),
        ),

        const SizedBox(height: 6),

        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Text(
            description,
            style: TextStyle(
              fontSize: wide ? 16 : 14,
              height: 1.65,
              color: AppTheme.cocoa.withValues(alpha: 0.85),
            ),
          ),
        ),

        const SizedBox(height: 18),

        // KARTU INFO
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppTheme.mintSoft,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppTheme.mint,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.local_mall_outlined,
                  size: 22,
                  color: AppTheme.cocoa,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Fresh & Homemade',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.cocoa,
                      ),
                    ),

                    Text(
                      'Dibuat dengan bahan pilihan dan rasa yang lembut.',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.cocoa.withValues(alpha: 0.85),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // =========================================================
  // QUANTITY + TOMBOL TAMBAH
  // =========================================================

  Widget _buildActions(double height) {
    return Row(
      children: [
        Container(
          height: height,
          decoration: BoxDecoration(
            color: AppTheme.softPink,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                tooltip: 'Kurangi',
                onPressed: _quantity > 1
                    ? () {
                        setState(() {
                          _quantity--;
                        });
                      }
                    : null,
                icon: const Icon(Icons.remove_rounded),
                color: AppTheme.cocoa,
                disabledColor: AppTheme.cocoa.withValues(alpha: 0.3),
                constraints: BoxConstraints(minWidth: 44, minHeight: height),
                padding: EdgeInsets.zero,
              ),

              SizedBox(
                width: 26,
                child: Text(
                  '$_quantity',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.cocoa,
                  ),
                ),
              ),

              IconButton(
                tooltip: 'Tambah',
                onPressed: () {
                  setState(() {
                    _quantity++;
                  });
                },
                icon: const Icon(Icons.add_rounded),
                color: AppTheme.cocoa,
                constraints: BoxConstraints(minWidth: 44, minHeight: height),
                padding: EdgeInsets.zero,
              ),
            ],
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: GradientButton(
            label: 'Tambah • ${_formatRupiah(_price * _quantity)}',
            height: height,
            onPressed: _addToCart,
          ),
        ),
      ],
    );
  }

  // =========================================================
  // LAYOUT SEMPIT (ponsel, tablet kecil)
  // =========================================================

  Widget _buildNarrowHero() {
    return Container(
      color: AppTheme.softPink,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Positioned(
            top: -40,
            right: -30,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: AppTheme.yellow.withValues(alpha: 0.6),
                shape: BoxShape.circle,
              ),
            ),
          ),

          Positioned(
            top: 220,
            right: 30,
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: AppTheme.peach.withValues(alpha: 0.8),
                shape: BoxShape.circle,
              ),
            ),
          ),

          Positioned(
            top: 64,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 224,
                height: 224,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.cocoa.withValues(alpha: 0.18),
                      blurRadius: 24,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: MochiImage(
                  path: mochi.image,
                  width: 212,
                  height: 212,
                  borderRadius: 106,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNarrowBody() {
    final topInset = MediaQuery.of(context).padding.top;

    return Stack(
      children: [
        // Latar hero
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: 340,
          child: _buildNarrowHero(),
        ),

        // Isi yang bisa di-scroll
        LayoutBuilder(
          builder: (context, constraints) {
            // Tinggi minimum tidak boleh negatif (layar pendek).
            final minHeight = math.max(0.0, constraints.maxHeight - 300);

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(top: 300),
              child: Container(
                width: double.infinity,
                constraints: BoxConstraints(minHeight: minHeight),
                padding: const EdgeInsets.fromLTRB(22, 24, 22, 24),
                decoration: const BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                ),
                child: _buildInfoColumn(false),
              ),
            );
          },
        ),

        Positioned(top: topInset + 8, left: 20, child: _buildBackButton()),

        Positioned(top: topInset + 8, right: 20, child: _buildHeartButton()),
      ],
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
      decoration: BoxDecoration(
        color: AppTheme.white,
        boxShadow: [
          BoxShadow(
            color: AppTheme.cocoa.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, -8),
          ),
        ],
      ),
      child: SafeArea(top: false, child: _buildActions(54)),
    );
  }

  // =========================================================
  // LAYOUT LEBAR (dua panel)
  // =========================================================

  Widget _buildWideHero() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(36),
      child: Container(
        color: AppTheme.softPink,
        child: Stack(
          children: [
            Positioned(
              top: -60,
              right: -40,
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  color: AppTheme.yellow.withValues(alpha: 0.6),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            Positioned(
              bottom: 60,
              left: 50,
              child: Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: AppTheme.peach.withValues(alpha: 0.8),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            Center(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final base =
                      math.min(constraints.maxWidth, constraints.maxHeight) *
                      0.72;
                  final size = math.max(220.0, math.min(460.0, base));

                  return Container(
                    width: size,
                    height: size,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppTheme.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.cocoa.withValues(alpha: 0.18),
                          blurRadius: 28,
                          offset: const Offset(0, 14),
                        ),
                      ],
                    ),
                    child: MochiImage(
                      path: mochi.image,
                      width: size - 16,
                      height: size - 16,
                      borderRadius: (size - 16) / 2,
                    ),
                  );
                },
              ),
            ),

            Positioned(top: 24, left: 24, child: _buildBackButton()),

            Positioned(top: 24, right: 24, child: _buildHeartButton()),
          ],
        ),
      ),
    );
  }

  Widget _buildWideInfo() {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(36),
        boxShadow: [
          BoxShadow(
            color: AppTheme.cocoa.withValues(alpha: 0.06),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(child: SingleChildScrollView(child: _buildInfoColumn(true))),

          const SizedBox(height: 20),

          _buildActions(58),
        ],
      ),
    );
  }

  Widget _buildWideBody() {
    return SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: Breakpoints.maxContent),
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: _buildWideHero()),

                const SizedBox(width: 32),

                Expanded(child: _buildWideInfo()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width >= Breakpoints.wide;

    return Scaffold(
      backgroundColor: AppTheme.cream,
      body: isWide ? _buildWideBody() : _buildNarrowBody(),
      bottomNavigationBar: isWide ? null : _buildBottomBar(),
    );
  }
}
