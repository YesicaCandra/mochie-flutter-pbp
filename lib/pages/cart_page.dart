import 'package:flutter/material.dart';

import '../app_data.dart';
import '../theme/app_theme.dart';
import 'checkout_page.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  String _formatRupiah(double value) {
    final text = value.round().toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (match) => '${match.group(1)}.',
    );

    return 'Rp$text';
  }

  int _getQuantity(Map<String, dynamic> item) {
    return item['quantity'] ?? 1;
  }

  double _getItemPrice(Map<String, dynamic> item) {
    final priceText = item['price']
        .toString()
        .replaceAll('Rp', '')
        .replaceAll('.', '')
        .replaceAll(',', '')
        .trim();

    return double.tryParse(priceText) ?? 0;
  }

  Future<void> _confirmRemove(
    BuildContext context,
    Map<String, dynamic> item,
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
            'Hapus Mochi?',
            style: TextStyle(
              color: AppTheme.darkPlum,
              fontWeight: FontWeight.w800,
            ),
          ),
          content: Text(
            'Apakah kamu yakin ingin menghapus ${item['name']} dari cart?',
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
      AppData.removeFromCart(item['name']);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${item['name']} dihapus dari cart'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: AppTheme.darkPlum,
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        );
      }
    }
  }

  Future<void> _confirmClearCart(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppTheme.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          title: const Text(
            'Kosongkan Cart?',
            style: TextStyle(
              color: AppTheme.darkPlum,
              fontWeight: FontWeight.w800,
            ),
          ),
          content: const Text(
            'Semua produk di cart akan dihapus. Kamu yakin ingin melanjutkan?',
            style: TextStyle(color: AppTheme.darkPlum, height: 1.5),
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
                'KOSONGKAN',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ],
        );
      },
    );

    if (result == true) {
      AppData.clearCart();

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Cart berhasil dikosongkan'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: AppTheme.darkPlum,
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        );
      }
    }
  }

  Widget _quantityButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: AppTheme.softPink,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, size: 18, color: AppTheme.darkPlum),
      ),
    );
  }

  Widget _cartItem(BuildContext context, Map<String, dynamic> item) {
    final quantity = _getQuantity(item);
    final price = _getItemPrice(item);
    final subtotal = price * quantity;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: AppTheme.darkPlum.withValues(alpha: 0.06),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              item['image'],
              width: 90,
              height: 90,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        item['name'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: AppTheme.darkPlum,
                        ),
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        _confirmRemove(context, item);
                      },
                      icon: const Icon(
                        Icons.delete_outline_rounded,
                        color: AppTheme.dustyRoseDark,
                      ),
                      tooltip: 'Hapus',
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                Text(
                  item['price'],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.dustyRoseDark,
                  ),
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    _quantityButton(
                      icon: Icons.remove,
                      onPressed: () {
                        AppData.decreaseQuantity(item['name']);
                      },
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Text(
                        '$quantity',
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          color: AppTheme.darkPlum,
                        ),
                      ),
                    ),

                    _quantityButton(
                      icon: Icons.add,
                      onPressed: () {
                        AppData.increaseQuantity(item['name']);
                      },
                    ),

                    const Spacer(),

                    Text(
                      _formatRupiah(subtotal),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.darkPlum,
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
  }

  Widget _emptyCart(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon keranjang
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: AppTheme.softPink,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.shopping_bag_outlined,
                size: 48,
                color: AppTheme.dustyRoseDark,
              ),
            ),

            const SizedBox(height: 24),

            // Judul
            const Text(
              'Keranjangmu Masih Kosong',
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
              'dan mulai pesan sesuatu yang manis ✨',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summary(BuildContext context, double total) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: [
          BoxShadow(
            color: AppTheme.darkPlum.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  'Total Pesanan',
                  style: TextStyle(fontSize: 15, color: AppTheme.darkPlum),
                ),
                const Spacer(),
                Text(
                  _formatRupiah(total),
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w900,
                    color: AppTheme.darkPlum,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CheckoutPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.arrow_forward_rounded),
                label: const Text(
                  'LANJUT KE CHECKOUT',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.darkPlum,
                  foregroundColor: AppTheme.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.cream,
      appBar: AppBar(
        title: const Text(
          'My Cart',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        actions: [
          ValueListenableBuilder<List<Map<String, dynamic>>>(
            valueListenable: AppData.cart,
            builder: (context, cart, child) {
              if (cart.isEmpty) {
                return const SizedBox.shrink();
              }

              return TextButton.icon(
                onPressed: () {
                  _confirmClearCart(context);
                },
                icon: const Icon(
                  Icons.delete_sweep_outlined,
                  color: AppTheme.darkPlum,
                ),
                label: const Text(
                  'Kosongkan',
                  style: TextStyle(
                    color: AppTheme.darkPlum,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              );
            },
          ),
        ],
      ),

      body: ValueListenableBuilder<List<Map<String, dynamic>>>(
        valueListenable: AppData.cart,
        builder: (context, cart, child) {
          if (cart.isEmpty) {
            return _emptyCart(context);
          }

          final total = AppData.getCartTotal();

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
                  itemCount: cart.length,
                  itemBuilder: (context, index) {
                    return _cartItem(context, cart[index]);
                  },
                ),
              ),

              _summary(context, total),
            ],
          );
        },
      ),
    );
  }
}
