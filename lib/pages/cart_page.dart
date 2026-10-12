import 'package:flutter/material.dart';

import '../app_data.dart';
import '../theme/app_theme.dart';
import '../widgets/app_snackbar.dart';
import '../widgets/gradient_button.dart';
import '../widgets/mochi_image.dart';
import '../widgets/responsive.dart';
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

  // =========================================================
  // KONFIRMASI HAPUS ITEM
  // =========================================================

  Future<void> _confirmRemove(
    BuildContext context,
    Map<String, dynamic> item,
  ) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Hapus Mochi?'),
          content: Text(
            'Apakah kamu yakin ingin menghapus ${item['name']} dari cart?',
          ),
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
      AppData.removeFromCart(item['name']);

      if (context.mounted) {
        AppSnackBar.show(
          context,
          '${item['name']} dihapus dari cart',
          icon: Icons.delete_outline_rounded,
        );
      }
    }
  }

  // =========================================================
  // KONFIRMASI KOSONGKAN CART
  // =========================================================

  Future<void> _confirmClearCart(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Kosongkan Cart?'),
          content: const Text(
            'Semua produk di cart akan dihapus. Kamu yakin ingin melanjutkan?',
          ),
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
              child: const Text('KOSONGKAN'),
            ),
          ],
        );
      },
    );

    if (result == true) {
      AppData.clearCart();

      if (context.mounted) {
        AppSnackBar.show(
          context,
          'Cart berhasil dikosongkan',
          icon: Icons.delete_sweep_outlined,
        );
      }
    }
  }

  // =========================================================
  // TOMBOL +/-
  // =========================================================

  Widget _quantityButton({
    required IconData icon,
    required String tooltip,
    required VoidCallback onPressed,
  }) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(14),
        child: SizedBox(
          width: 40,
          height: 38,
          child: Icon(icon, size: 20, color: AppTheme.cocoa),
        ),
      ),
    );
  }

  // =========================================================
  // ITEM KERANJANG
  // =========================================================

  Widget _cartItem(BuildContext context, Map<String, dynamic> item) {
    final quantity = _getQuantity(item);
    final price = _getItemPrice(item);
    final subtotal = price * quantity;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(10),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MochiImage(
            path: item['image'].toString(),
            width: 86,
            height: 98,
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
                        item['name'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: AppTheme.fontDisplay,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.cocoa,
                        ),
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        _confirmRemove(context, item);
                      },
                      icon: const Icon(
                        Icons.delete_outline_rounded,
                        size: 22,
                        color: AppTheme.primaryDeep,
                      ),
                      tooltip: 'Hapus',
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 34,
                        minHeight: 34,
                      ),
                    ),
                  ],
                ),

                Text(
                  item['price'],
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.primaryDeep,
                  ),
                ),

                const SizedBox(height: 10),

                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppTheme.softPink,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _quantityButton(
                            icon: Icons.remove_rounded,
                            tooltip: 'Kurangi',
                            onPressed: () {
                              AppData.decreaseQuantity(item['name']);
                            },
                          ),

                          SizedBox(
                            width: 22,
                            child: Text(
                              '$quantity',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                color: AppTheme.cocoa,
                              ),
                            ),
                          ),

                          _quantityButton(
                            icon: Icons.add_rounded,
                            tooltip: 'Tambah',
                            onPressed: () {
                              AppData.increaseQuantity(item['name']);
                            },
                          ),
                        ],
                      ),
                    ),

                    const Spacer(),

                    Text(
                      _formatRupiah(subtotal),
                      style: const TextStyle(
                        fontFamily: AppTheme.fontDisplay,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.cocoa,
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

  // =========================================================
  // KERANJANG KOSONG
  // =========================================================

  Widget _emptyCart(BuildContext context) {
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
                Icons.shopping_bag_outlined,
                size: 48,
                color: AppTheme.primary,
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Keranjangmu Masih Kosong',
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
              'dan mulai pesan sesuatu yang manis ✨',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color: AppTheme.cocoa.withValues(alpha: 0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _goToCheckout(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CheckoutPage()),
    );
  }

  // =========================================================
  // RINGKASAN BAWAH (layar sempit)
  // =========================================================

  Widget _summary(BuildContext context, double total) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: [
          BoxShadow(
            color: AppTheme.cocoa.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, -8),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Text(
                  'Total Pesanan',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.cocoa,
                  ),
                ),
                const Spacer(),
                Text(
                  _formatRupiah(total),
                  style: const TextStyle(
                    fontFamily: AppTheme.fontDisplay,
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primaryDeep,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            SizedBox(
              width: double.infinity,
              child: GradientButton(
                label: 'LANJUT KE CHECKOUT',
                trailingIcon: Icons.arrow_forward_rounded,
                onPressed: () {
                  _goToCheckout(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // PANEL RINGKASAN (layar lebar)
  // =========================================================

  Widget _summaryPanel(BuildContext context, double total, int itemCount) {
    return Container(
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppTheme.cocoa.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Ringkasan',
            style: TextStyle(
              fontFamily: AppTheme.fontDisplay,
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: AppTheme.cocoa,
            ),
          ),

          const SizedBox(height: 16),

          _panelRow('Jumlah item', '$itemCount'),

          const SizedBox(height: 8),

          _panelRow('Subtotal', _formatRupiah(total)),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(height: 1, thickness: 1.5, color: AppTheme.peach),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Pesanan',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: AppTheme.cocoa,
                ),
              ),
              Text(
                _formatRupiah(total),
                style: const TextStyle(
                  fontFamily: AppTheme.fontDisplay,
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.primaryDeep,
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          SizedBox(
            width: double.infinity,
            child: GradientButton(
              label: 'LANJUT KE CHECKOUT',
              trailingIcon: Icons.arrow_forward_rounded,
              onPressed: () {
                _goToCheckout(context);
              },
            ),
          ),

          const SizedBox(height: 12),

          Center(
            child: Text(
              'Ongkir dihitung di langkah berikutnya',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppTheme.cocoa.withValues(alpha: 0.75),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _panelRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppTheme.cocoa,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppTheme.cocoa,
          ),
        ),
      ],
    );
  }

  // =========================================================
  // BODY
  // =========================================================

  Widget _buildBody(
    BuildContext context,
    List<Map<String, dynamic>> cart,
    double total,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= Breakpoints.wide;

        if (isWide) {
          final itemCount = cart.fold<int>(
            0,
            (sum, item) => sum + _getQuantity(item),
          );

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: Breakpoints.maxContent,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(32, 8, 32, 32),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: cart.length,
                        itemBuilder: (context, index) {
                          return _cartItem(context, cart[index]);
                        },
                      ),
                    ),

                    const SizedBox(width: 28),

                    SizedBox(
                      width: 360,
                      child: SingleChildScrollView(
                        child: _summaryPanel(context, total, itemCount),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return ResponsiveCenter(
          maxWidth: 720,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                  itemCount: cart.length,
                  itemBuilder: (context, index) {
                    return _cartItem(context, cart[index]);
                  },
                ),
              ),

              _summary(context, total),
            ],
          ),
        );
      },
    );
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.cream,
      appBar: AppBar(
        title: const Text('My Cart'),
        actions: [
          ValueListenableBuilder<List<Map<String, dynamic>>>(
            valueListenable: AppData.cart,
            builder: (context, cart, child) {
              if (cart.isEmpty) {
                return const SizedBox.shrink();
              }

              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: TextButton(
                  onPressed: () {
                    _confirmClearCart(context);
                  },
                  child: const Text('Kosongkan'),
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

          return _buildBody(context, cart, total);
        },
      ),
    );
  }
}
