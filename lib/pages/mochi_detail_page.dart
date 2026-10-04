import 'package:flutter/material.dart';

import '../app_data.dart';
import '../models/mochi.dart';
import '../theme/app_theme.dart';

import 'cart_page.dart';

class MochiDetailPage extends StatelessWidget {
  final Mochi mochi;

  const MochiDetailPage({super.key, required this.mochi});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.cream,

      // =========================================================
      // APP BAR
      // =========================================================
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppTheme.darkPlum,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Detail Mochi',
          style: TextStyle(
            color: AppTheme.darkPlum,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      // =========================================================
      // BODY
      // =========================================================
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =====================================================
            // IMAGE
            // =====================================================

            Container(
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              width: double.infinity,
              height: 280,
              decoration: BoxDecoration(
                color: AppTheme.white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.dustyRoseDark.withValues(alpha: 0.12),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: Image.asset(mochi.image, fit: BoxFit.cover),
              ),
            ),

            const SizedBox(height: 24),

            // =====================================================
            // CONTENT
            // =====================================================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // =================================================
                  // NAME
                  // =================================================

                  Text(
                    mochi.name,
                    style: const TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.darkPlum,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // =================================================
                  // RATING
                  // =================================================
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.softPink,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              size: 19,
                              color: AppTheme.dustyRoseDark,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              mochi.rating.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppTheme.darkPlum,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 12),

                      Text(
                        'Favorit pelanggan',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppTheme.darkPlum.withValues(alpha: 0.55),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  // =================================================
                  // PRICE
                  // =================================================
                  Text(
                    mochi.price,
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.dustyRoseDark,
                    ),
                  ),

                  const SizedBox(height: 22),

                  // =================================================
                  // DESCRIPTION TITLE
                  // =================================================
                  const Text(
                    'Tentang Mochi',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.darkPlum,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // =================================================
                  // DESCRIPTION
                  // =================================================
                  Text(
                    mochi.detailDescription.isNotEmpty
                        ? mochi.detailDescription
                        : mochi.description,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.7,
                      color: AppTheme.darkPlum.withValues(alpha: 0.70),
                    ),
                  ),

                  const SizedBox(height: 28),

                  // =================================================
                  // INFORMATION CARD
                  // =================================================
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: AppTheme.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppTheme.dustyRose.withValues(alpha: 0.40),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppTheme.softPink,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Icon(
                            Icons.local_mall_outlined,
                            color: AppTheme.dustyRoseDark,
                            size: 24,
                          ),
                        ),

                        const SizedBox(width: 14),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Fresh & Homemade',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.darkPlum,
                                ),
                              ),

                              const SizedBox(height: 4),

                              Text(
                                'Dibuat dengan bahan pilihan dan rasa yang lembut.',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppTheme.darkPlum.withValues(
                                    alpha: 0.55,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  // =================================================
                  // ADD TO CART BUTTON
                  // =================================================
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _showCart(context);
                      },
                      icon: const Icon(Icons.shopping_bag_outlined),
                      label: const Text(
                        'ADD TO CART',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.darkPlum,
                        foregroundColor: AppTheme.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =============================================================
  // CART BOTTOM SHEET
  // =============================================================

  void _showCart(BuildContext pageContext) {
    int quantity = 1;

    showModalBottomSheet(
      context: pageContext,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            // =====================================================
            // PRICE
            // =====================================================

            final priceText = mochi.price
                .replaceAll('Rp', '')
                .replaceAll('.', '')
                .replaceAll(',', '')
                .trim();

            final price = double.tryParse(priceText) ?? 0;

            final subtotal = price * quantity;

            return Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
              decoration: const BoxDecoration(
                color: AppTheme.cream,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // =================================================
                    // HANDLE
                    // =================================================

                    Container(
                      width: 42,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppTheme.dustyRose,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // =================================================
                    // TITLE
                    // =================================================
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Pesanan Kamu',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.darkPlum,
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    // =================================================
                    // PRODUCT
                    // =================================================
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppTheme.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              mochi.image,
                              width: 75,
                              height: 75,
                              fit: BoxFit.cover,
                            ),
                          ),

                          const SizedBox(width: 14),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  mochi.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.darkPlum,
                                  ),
                                ),

                                const SizedBox(height: 6),

                                Text(
                                  mochi.price,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.dustyRoseDark,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(width: 8),

                          // =================================================
                          // QUANTITY
                          // =================================================
                          Container(
                            decoration: BoxDecoration(
                              color: AppTheme.softPink,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // MINUS
                                IconButton(
                                  onPressed: quantity > 1
                                      ? () {
                                          setModalState(() {
                                            quantity--;
                                          });
                                        }
                                      : null,
                                  icon: const Icon(
                                    Icons.remove_rounded,
                                    size: 18,
                                  ),
                                  color: AppTheme.darkPlum,
                                  disabledColor: AppTheme.darkPlum.withValues(
                                    alpha: 0.25,
                                  ),
                                  constraints: const BoxConstraints(
                                    minWidth: 38,
                                    minHeight: 38,
                                  ),
                                  padding: EdgeInsets.zero,
                                ),

                                // NUMBER
                                Container(
                                  constraints: const BoxConstraints(
                                    minWidth: 28,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    quantity.toString(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.darkPlum,
                                    ),
                                  ),
                                ),

                                // PLUS
                                IconButton(
                                  onPressed: () {
                                    setModalState(() {
                                      quantity++;
                                    });
                                  },
                                  icon: const Icon(Icons.add_rounded, size: 18),
                                  color: AppTheme.darkPlum,
                                  constraints: const BoxConstraints(
                                    minWidth: 38,
                                    minHeight: 38,
                                  ),
                                  padding: EdgeInsets.zero,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 22),

                    // =================================================
                    // SUMMARY
                    // =================================================
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: AppTheme.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          _summaryRow('Harga', _formatRupiah(price)),

                          const SizedBox(height: 10),

                          _summaryRow('Jumlah', quantity.toString()),

                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Divider(),
                          ),

                          _summaryRow(
                            'Subtotal',
                            _formatRupiah(subtotal),
                            isTotal: true,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // =================================================
                    // ADD TO CART
                    // =================================================
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: () {
                          // =================================================
                          // TAMBAHKAN SESUAI JUMLAH
                          // =================================================

                          for (int i = 0; i < quantity; i++) {
                            AppData.addToCart(mochi.toMap());
                          }

                          // =================================================
                          // TUTUP BOTTOM SHEET
                          // =================================================

                          Navigator.pop(context);

                          // =================================================
                          // NOTIFIKASI
                          // =================================================

                          ScaffoldMessenger.of(pageContext).showSnackBar(
                            SnackBar(
                              content: Row(
                                children: [
                                  const Icon(
                                    Icons.check_circle_outline,
                                    color: AppTheme.white,
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      '$quantity ${mochi.name} berhasil ditambahkan ke keranjang',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              action: SnackBarAction(
                                label: 'LIHAT CART',
                                textColor: AppTheme.softPink,
                                onPressed: () {
                                  Navigator.push(
                                    pageContext,
                                    MaterialPageRoute(
                                      builder: (_) => const CartPage(),
                                    ),
                                  );
                                },
                              ),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: AppTheme.darkPlum,
                              margin: const EdgeInsets.all(16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              duration: const Duration(seconds: 4),
                            ),
                          );
                        },

                        // =================================================
                        // BUTTON STYLE
                        // =================================================
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.darkPlum,
                          foregroundColor: AppTheme.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),

                        // =================================================
                        // BUTTON TEXT
                        // =================================================
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.shopping_bag_outlined, size: 20),

                            SizedBox(width: 8),

                            Text(
                              'TAMBAH KE KERANJANG',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // =============================================================
  // FORMAT RUPIAH
  // =============================================================

  String _formatRupiah(double value) {
    final number = value.toInt().toString();

    final formatted = number.replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]}.',
    );

    return 'Rp$formatted';
  }

  // =============================================================
  // SUMMARY ROW
  // =============================================================

  Widget _summaryRow(String title, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isTotal ? 15 : 13,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
            color: AppTheme.darkPlum.withValues(alpha: isTotal ? 1 : 0.60),
          ),
        ),

        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 16 : 13,
            fontWeight: FontWeight.bold,
            color: isTotal ? AppTheme.dustyRoseDark : AppTheme.darkPlum,
          ),
        ),
      ],
    );
  }
}
