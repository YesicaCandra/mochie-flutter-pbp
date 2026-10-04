import 'package:flutter/material.dart';

import '../app_data.dart';
import '../theme/app_theme.dart';
import 'order_history_page.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  // =========================================================
  // CONTROLLER
  // =========================================================

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _addressController = TextEditingController();

  // =========================================================
  // PILIHAN PENGIRIMAN
  // =========================================================

  String _selectedShipping = 'Reguler';

  // =========================================================
  // PILIHAN PEMBAYARAN
  // =========================================================

  String _selectedPayment = 'COD';

  // =========================================================
  // ONGKIR
  // =========================================================

  double get _shippingCost {
    if (_selectedShipping == 'Express') {
      return 15000;
    }

    return 8000;
  }

  // =========================================================
  // SUBTOTAL
  // =========================================================

  double get _subtotal {
    return AppData.getCartTotal();
  }

  // =========================================================
  // TOTAL
  // =========================================================

  double get _total {
    return _subtotal + _shippingCost;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();

    super.dispose();
  }

  // =========================================================
  // FORMAT RUPIAH
  // =========================================================

  String _formatRupiah(double value) {
    final number = value.toInt().toString();

    final formatted = number.replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]}.',
    );

    return 'Rp$formatted';
  }

  // =========================================================
  // VALIDASI FORM
  // =========================================================

  bool _validateForm() {
    if (_nameController.text.trim().isEmpty) {
      _showMessage('Nama belum diisi');
      return false;
    }

    if (_phoneController.text.trim().isEmpty) {
      _showMessage('Nomor telepon belum diisi');
      return false;
    }

    if (_addressController.text.trim().isEmpty) {
      _showMessage('Alamat belum diisi');
      return false;
    }

    if (AppData.cart.value.isEmpty) {
      _showMessage('Keranjang masih kosong');
      return false;
    }

    return true;
  }

  // =========================================================
  // SNACKBAR
  // =========================================================

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppTheme.darkPlum,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  // =========================================================
  // KONFIRMASI PESANAN
  // =========================================================

  void _showConfirmationDialog() {
    if (!_validateForm()) {
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppTheme.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
          contentPadding: const EdgeInsets.fromLTRB(24, 8, 24, 12),
          actionsPadding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.softPink,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.shopping_bag_outlined,
                  color: AppTheme.dustyRoseDark,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Konfirmasi Pesanan',
                  style: TextStyle(
                    color: AppTheme.darkPlum,
                    fontWeight: FontWeight.bold,
                    fontSize: 21,
                  ),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pesanan akan dibuat dengan detail:',
                style: TextStyle(
                  color: AppTheme.darkPlum.withValues(alpha: 0.60),
                  fontSize: 13,
                ),
              ),

              const SizedBox(height: 18),

              _confirmationRow('Nama', _nameController.text.trim()),

              const SizedBox(height: 10),

              _confirmationRow('Telepon', _phoneController.text.trim()),

              const SizedBox(height: 10),

              _confirmationRow('Pengiriman', _selectedShipping),

              const SizedBox(height: 10),

              _confirmationRow('Pembayaran', _selectedPayment),

              const SizedBox(height: 14),

              const Divider(color: AppTheme.dustyRose),

              const SizedBox(height: 8),

              _confirmationRow('Total', _formatRupiah(_total), bold: true),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text(
                'Batal',
                style: TextStyle(color: AppTheme.darkPlum),
              ),
            ),

            const SizedBox(width: 8),

            ElevatedButton(
              onPressed: () {
                _createOrder(dialogContext);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.darkPlum,
                foregroundColor: AppTheme.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 13,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'Konfirmasi',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  // =========================================================
  // ROW KONFIRMASI
  // =========================================================

  Widget _confirmationRow(String title, String value, {bool bold = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 95,
          child: Text(
            title,
            style: TextStyle(
              color: AppTheme.darkPlum.withValues(alpha: 0.55),
              fontSize: 13,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: AppTheme.darkPlum,
              fontSize: 13,
              fontWeight: bold ? FontWeight.bold : FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  // =========================================================
  // MEMBUAT ORDER
  // =========================================================

  void _createOrder(BuildContext dialogContext) {
    // Buat ID unik untuk pesanan.
    final orderId = 'MOCHI-${DateTime.now().millisecondsSinceEpoch}';

    // Pastikan semua data String tidak pernah null.
    final customerName = _nameController.text.trim().isEmpty
        ? 'Pelanggan'
        : _nameController.text.trim();

    final phone = _phoneController.text.trim().isEmpty
        ? '-'
        : _phoneController.text.trim();

    final address = _addressController.text.trim().isEmpty
        ? '-'
        : _addressController.text.trim();

    // =======================================================
    // DATA ORDER
    // =======================================================

    final Map<String, dynamic> order = {
      'orderId': orderId,
      'customerName': customerName,
      'phone': phone,
      'address': address,
      'shippingMethod': _selectedShipping,
      'paymentMethod': _selectedPayment,
      'subtotal': _subtotal,
      'shippingCost': _shippingCost,
      'total': _total,
      'status': 'Pesanan dibuat',
    };

    // =======================================================
    // SIMPAN ORDER
    // =======================================================

    AppData.addOrder(order);

    // =======================================================
    // KOSONGKAN CART
    // =======================================================

    AppData.clearCart();

    // =======================================================
    // TUTUP DIALOG
    // =======================================================

    Navigator.pop(dialogContext);

    // =======================================================
    // PINDAH KE ORDER HISTORY
    // =======================================================

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const OrderHistoryPage()),
    );

    // =======================================================
    // NOTIFIKASI
    // =======================================================

    Future.delayed(const Duration(milliseconds: 400), () {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.check_circle_outline, color: AppTheme.white),
              SizedBox(width: 10),
              Expanded(child: Text('Pesanan berhasil dibuat! 🍡')),
            ],
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppTheme.darkPlum,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      );
    });
  }

  // =========================================================
  // TEXT FIELD
  // =========================================================

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: const TextStyle(
        color: AppTheme.darkPlum,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: AppTheme.dustyRoseDark),
        filled: true,
        fillColor: AppTheme.white,
        labelStyle: TextStyle(color: AppTheme.darkPlum.withValues(alpha: 0.60)),
        hintStyle: TextStyle(color: AppTheme.darkPlum.withValues(alpha: 0.35)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(
            color: AppTheme.dustyRose.withValues(alpha: 0.45),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: AppTheme.dustyRoseDark,
            width: 1.5,
          ),
        ),
      ),
    );
  }

  // =========================================================
  // SHIPPING CARD
  // =========================================================

  Widget _buildShippingOption({
    required String title,
    required String subtitle,
    required double price,
  }) {
    final selected = _selectedShipping == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedShipping = title;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected ? AppTheme.softPink : AppTheme.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: selected
                ? AppTheme.dustyRoseDark
                : AppTheme.dustyRose.withValues(alpha: 0.55),
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: selected ? AppTheme.dustyRose : AppTheme.cream,
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(
                title == 'Express'
                    ? Icons.flash_on_outlined
                    : Icons.local_shipping_outlined,
                color: AppTheme.darkPlum,
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: AppTheme.darkPlum,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: AppTheme.darkPlum.withValues(alpha: 0.55),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            Text(
              _formatRupiah(price),
              style: const TextStyle(
                color: AppTheme.darkPlum,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(width: 8),

            Icon(
              selected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: selected
                  ? AppTheme.dustyRoseDark
                  : AppTheme.darkPlum.withValues(alpha: 0.30),
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // PAYMENT CARD
  // =========================================================

  Widget _buildPaymentOption({required String title, required IconData icon}) {
    final selected = _selectedPayment == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPayment = title;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected ? AppTheme.softPink : AppTheme.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: selected
                ? AppTheme.dustyRoseDark
                : AppTheme.dustyRose.withValues(alpha: 0.55),
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: selected ? AppTheme.dustyRose : AppTheme.cream,
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(icon, color: AppTheme.darkPlum),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: AppTheme.darkPlum,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Icon(
              selected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: selected
                  ? AppTheme.dustyRoseDark
                  : AppTheme.darkPlum.withValues(alpha: 0.30),
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // SUMMARY ROW
  // =========================================================

  Widget _summaryRow(String title, String value, {bool bold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: AppTheme.darkPlum.withValues(alpha: bold ? 1 : 0.60),
            fontWeight: bold ? FontWeight.bold : FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: AppTheme.darkPlum,
            fontWeight: FontWeight.bold,
            fontSize: bold ? 17 : 14,
          ),
        ),
      ],
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
        title: const Text(
          'Checkout',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppTheme.darkPlum,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppTheme.darkPlum,
      ),

      body: ValueListenableBuilder<List<Map<String, dynamic>>>(
        valueListenable: AppData.cart,
        builder: (context, cart, child) {
          if (cart.isEmpty) {
            return _buildEmptyCart();
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // =================================================
                // DATA PEMESAN
                // =================================================

                const Text(
                  'Informasi Pemesan',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.darkPlum,
                  ),
                ),

                const SizedBox(height: 14),

                _buildTextField(
                  controller: _nameController,
                  label: 'Nama',
                  hint: 'Masukkan nama kamu',
                  icon: Icons.person_outline,
                ),

                const SizedBox(height: 12),

                _buildTextField(
                  controller: _phoneController,
                  label: 'Nomor Telepon',
                  hint: 'Contoh: 08123456789',
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                ),

                const SizedBox(height: 12),

                _buildTextField(
                  controller: _addressController,
                  label: 'Alamat Pengiriman',
                  hint: 'Masukkan alamat lengkap',
                  icon: Icons.location_on_outlined,
                  maxLines: 3,
                ),

                const SizedBox(height: 28),

                // =================================================
                // PENGIRIMAN
                // =================================================
                const Text(
                  'Metode Pengiriman',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.darkPlum,
                  ),
                ),

                const SizedBox(height: 14),

                _buildShippingOption(
                  title: 'Reguler',
                  subtitle: 'Estimasi 2–4 hari',
                  price: 8000,
                ),

                _buildShippingOption(
                  title: 'Express',
                  subtitle: 'Estimasi 1–2 hari',
                  price: 15000,
                ),

                const SizedBox(height: 16),

                // =================================================
                // PEMBAYARAN
                // =================================================
                const Text(
                  'Metode Pembayaran',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.darkPlum,
                  ),
                ),

                const SizedBox(height: 14),

                _buildPaymentOption(
                  title: 'COD',
                  icon: Icons.payments_outlined,
                ),

                _buildPaymentOption(
                  title: 'Transfer Bank',
                  icon: Icons.account_balance_outlined,
                ),

                _buildPaymentOption(
                  title: 'E-Wallet',
                  icon: Icons.account_balance_wallet_outlined,
                ),

                const SizedBox(height: 16),

                // =================================================
                // RINGKASAN
                // =================================================
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppTheme.dustyRose,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Ringkasan Pesanan',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.darkPlum,
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      _summaryRow('Subtotal', _formatRupiah(_subtotal)),

                      const SizedBox(height: 10),

                      _summaryRow('Pengiriman', _formatRupiah(_shippingCost)),

                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        child: Divider(color: AppTheme.white),
                      ),

                      _summaryRow('Total', _formatRupiah(_total), bold: true),
                    ],
                  ),
                ),

                const SizedBox(height: 22),

                // =================================================
                // BUTTON KONFIRMASI
                // =================================================
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton.icon(
                    onPressed: _showConfirmationDialog,
                    icon: const Icon(Icons.check_circle_outline),
                    label: const Text(
                      'KONFIRMASI PESANAN',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.4,
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

                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }

  // =========================================================
  // EMPTY CART
  // =========================================================

  Widget _buildEmptyCart() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppTheme.softPink,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.shopping_bag_outlined,
                size: 55,
                color: AppTheme.dustyRoseDark,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Keranjang masih kosong',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: AppTheme.darkPlum,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Tambahkan Mochi favoritmu terlebih dahulu.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppTheme.darkPlum.withValues(alpha: 0.60),
              ),
            ),

            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.darkPlum,
                foregroundColor: AppTheme.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text('KEMBALI'),
            ),
          ],
        ),
      ),
    );
  }
}
