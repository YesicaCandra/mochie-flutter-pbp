import 'package:flutter/material.dart';

import '../app_data.dart';
import '../theme/app_theme.dart';
import '../widgets/app_snackbar.dart';
import '../widgets/gradient_button.dart';
import '../widgets/mochi_image.dart';
import '../widgets/responsive.dart';
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

  // Pesan error yang tampil di bawah field.
  String? _nameError;
  String? _phoneError;
  String? _addressError;

  // =========================================================
  // PILIHAN PENGIRIMAN & PEMBAYARAN
  // =========================================================

  String _selectedShipping = 'Reguler';

  String _selectedPayment = 'COD';

  // =========================================================
  // ONGKIR, SUBTOTAL, TOTAL
  // =========================================================

  double get _shippingCost {
    if (_selectedShipping == 'Express') {
      return 15000;
    }

    return 8000;
  }

  double get _subtotal {
    return AppData.getCartTotal();
  }

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
  // FORMAT RUPIAH & HARGA ITEM
  // =========================================================

  String _formatRupiah(double value) {
    final number = value.toInt().toString();

    final formatted = number.replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]}.',
    );

    return 'Rp$formatted';
  }

  double _itemTotal(Map<String, dynamic> item) {
    final priceText = item['price']
        .toString()
        .replaceAll('Rp', '')
        .replaceAll('.', '')
        .replaceAll(',', '')
        .trim();

    final price = double.tryParse(priceText) ?? 0;

    final quantity = (item['quantity'] ?? 1) as int;

    return price * quantity;
  }

  // =========================================================
  // VALIDASI FORM
  // =========================================================

  bool _isValidPhone(String phone) {
    final onlyAllowed = RegExp(r'^[0-9+\s-]+$').hasMatch(phone);

    final digits = phone.replaceAll(RegExp(r'\D'), '');

    return onlyAllowed && digits.length >= 8 && digits.length <= 15;
  }

  bool _validateForm() {
    final name = _nameController.text.trim();
    final phone = _phoneController.text.trim();
    final address = _addressController.text.trim();

    String? nameError;
    String? phoneError;
    String? addressError;

    if (name.isEmpty) {
      nameError = 'Nama belum diisi';
    }

    if (phone.isEmpty) {
      phoneError = 'Nomor telepon belum diisi';
    } else if (!_isValidPhone(phone)) {
      phoneError = 'Nomor telepon tidak valid';
    }

    if (address.isEmpty) {
      addressError = 'Alamat belum diisi';
    }

    setState(() {
      _nameError = nameError;
      _phoneError = phoneError;
      _addressError = addressError;
    });

    if (nameError != null) {
      _showMessage(nameError);
      return false;
    }

    if (phoneError != null) {
      _showMessage(phoneError);
      return false;
    }

    if (addressError != null) {
      _showMessage(addressError);
      return false;
    }

    if (AppData.cart.value.isEmpty) {
      _showMessage('Keranjang masih kosong');
      return false;
    }

    return true;
  }

  void _showMessage(String message) {
    AppSnackBar.error(context, message);
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
                  color: AppTheme.primaryDeep,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(child: Text('Konfirmasi Pesanan')),
            ],
          ),
          content: SizedBox(
            width: 420,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pesanan akan dibuat dengan detail:',
                  style: TextStyle(
                    color: AppTheme.cocoa.withValues(alpha: 0.75),
                    fontSize: 13,
                  ),
                ),

                const SizedBox(height: 16),

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
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text(
                'Batal',
                style: TextStyle(color: AppTheme.cocoa),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                _createOrder(dialogContext);
              },
              child: const Text('Konfirmasi'),
            ),
          ],
        );
      },
    );
  }

  Widget _confirmationRow(String title, String value, {bool bold = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 95,
          child: Text(
            title,
            style: TextStyle(
              color: AppTheme.cocoa.withValues(alpha: 0.75),
              fontSize: 13,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: AppTheme.cocoa,
              fontSize: 13,
              fontWeight: bold ? FontWeight.w800 : FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  // =========================================================
  // MEMBUAT ORDER (urutan sama seperti sebelumnya)
  // =========================================================

  void _createOrder(BuildContext dialogContext) {
    // Buat ID unik untuk pesanan.
    final orderId = 'MOCHI-${DateTime.now().millisecondsSinceEpoch}';

    final customerName = _nameController.text.trim().isEmpty
        ? 'Pelanggan'
        : _nameController.text.trim();

    final phone = _phoneController.text.trim().isEmpty
        ? '-'
        : _phoneController.text.trim();

    final address = _addressController.text.trim().isEmpty
        ? '-'
        : _addressController.text.trim();

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

    // Messenger diambil sekarang karena halaman ini akan diganti.
    final messenger = ScaffoldMessenger.of(context);

    // SIMPAN ORDER (menyalin isi cart), LALU KOSONGKAN CART
    AppData.addOrder(order);

    AppData.clearCart();

    Navigator.pop(dialogContext);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const OrderHistoryPage()),
    );

    Future.delayed(const Duration(milliseconds: 400), () {
      messenger.hideCurrentSnackBar();

      messenger.showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle_outline, color: AppTheme.white),
              SizedBox(width: 10),
              Expanded(child: Text('Pesanan berhasil dibuat! 🍡')),
            ],
          ),
          margin: EdgeInsets.all(16),
        ),
      );
    });
  }

  // =========================================================
  // JUDUL SECTION
  // =========================================================

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: AppTheme.fontDisplay,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppTheme.cocoa,
      ),
    );
  }

  // =========================================================
  // FIELD (label di atas)
  // =========================================================

  Widget _buildField({
    required String label,
    required String hint,
    required TextEditingController controller,
    String? errorText,
    TextInputType? keyboardType,
    int maxLines = 1,
    ValueChanged<String>? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w800,
            color: AppTheme.cocoa,
          ),
        ),

        const SizedBox(height: 6),

        TextField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          onChanged: onChanged,
          style: const TextStyle(
            color: AppTheme.cocoa,
            fontWeight: FontWeight.w700,
          ),
          decoration: InputDecoration(
            hintText: hint,
            errorText: errorText,
            fillColor: AppTheme.cream,
          ),
        ),
      ],
    );
  }

  // =========================================================
  // OPSI PENGIRIMAN & PEMBAYARAN
  // =========================================================

  Widget _buildShippingOption({
    required String title,
    required String subtitle,
    required double price,
  }) {
    final selected = _selectedShipping == title;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedShipping = title;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: selected ? AppTheme.softPink : AppTheme.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected ? AppTheme.primary : AppTheme.dustyRose,
              width: selected ? 2 : 1.5,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.cocoa,
                ),
              ),

              const SizedBox(height: 2),

              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.cocoa.withValues(alpha: 0.8),
                ),
              ),

              const SizedBox(height: 4),

              Text(
                _formatRupiah(price),
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.primaryDeep,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentOption(String title) {
    final selected = _selectedPayment == title;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedPayment = title;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? AppTheme.primaryDeep : AppTheme.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: selected ? AppTheme.primaryDeep : AppTheme.dustyRose,
              width: 1.5,
            ),
          ),
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: selected ? AppTheme.white : AppTheme.cocoa,
            ),
          ),
        ),
      ),
    );
  }

  // =========================================================
  // BAGIAN FORM (dipakai layar sempit dan lebar)
  // =========================================================

  List<Widget> _formSections() {
    return [
      _sectionTitle('Informasi Pemesan'),

      const SizedBox(height: 10),

      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: AppTheme.cocoa.withValues(alpha: 0.06),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          children: [
            _buildField(
              label: 'Nama',
              hint: 'Masukkan nama kamu',
              controller: _nameController,
              errorText: _nameError,
              onChanged: (_) {
                if (_nameError != null) {
                  setState(() {
                    _nameError = null;
                  });
                }
              },
            ),

            const SizedBox(height: 12),

            _buildField(
              label: 'Nomor Telepon',
              hint: 'Contoh: 08123456789',
              controller: _phoneController,
              errorText: _phoneError,
              keyboardType: TextInputType.phone,
              onChanged: (_) {
                if (_phoneError != null) {
                  setState(() {
                    _phoneError = null;
                  });
                }
              },
            ),

            const SizedBox(height: 12),

            _buildField(
              label: 'Alamat Pengiriman',
              hint: 'Masukkan alamat lengkap',
              controller: _addressController,
              errorText: _addressError,
              maxLines: 3,
              onChanged: (_) {
                if (_addressError != null) {
                  setState(() {
                    _addressError = null;
                  });
                }
              },
            ),
          ],
        ),
      ),

      const SizedBox(height: 20),

      _sectionTitle('Metode Pengiriman'),

      const SizedBox(height: 10),

      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildShippingOption(
            title: 'Reguler',
            subtitle: 'Estimasi 2–4 hari',
            price: 8000,
          ),

          const SizedBox(width: 10),

          _buildShippingOption(
            title: 'Express',
            subtitle: 'Estimasi 1–2 hari',
            price: 15000,
          ),
        ],
      ),

      const SizedBox(height: 20),

      _sectionTitle('Metode Pembayaran'),

      const SizedBox(height: 10),

      Row(
        children: [
          _buildPaymentOption('COD'),
          const SizedBox(width: 8),
          _buildPaymentOption('Transfer Bank'),
          const SizedBox(width: 8),
          _buildPaymentOption('E-Wallet'),
        ],
      ),

      const SizedBox(height: 8),

      Text(
        'Catatan: pembayaran masih simulasi. Belum ada transaksi sungguhan.',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: AppTheme.cocoa.withValues(alpha: 0.75),
        ),
      ),
    ];
  }

  // =========================================================
  // KARTU RINGKASAN (daftar item + total + tombol)
  // =========================================================

  Widget _summaryItem(Map<String, dynamic> item) {
    final quantity = item['quantity'] ?? 1;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          MochiImage(
            path: item['image'].toString(),
            width: 46,
            height: 46,
            borderRadius: 12,
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              '${item['name']} × $quantity',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: AppTheme.cocoa,
              ),
            ),
          ),

          const SizedBox(width: 8),

          Text(
            _formatRupiah(_itemTotal(item)),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: AppTheme.cocoa,
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(String title, String value) {
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

  Widget _summaryCard(List<Map<String, dynamic>> cart) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
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
            'Ringkasan Pesanan',
            style: TextStyle(
              fontFamily: AppTheme.fontDisplay,
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: AppTheme.cocoa,
            ),
          ),

          const SizedBox(height: 14),

          ...cart.map(_summaryItem),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Divider(height: 1, thickness: 1.5, color: AppTheme.peach),
          ),

          _summaryRow('Subtotal', _formatRupiah(_subtotal)),

          const SizedBox(height: 8),

          _summaryRow('Pengiriman', _formatRupiah(_shippingCost)),

          const SizedBox(height: 14),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: AppTheme.softPink,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.cocoa,
                  ),
                ),
                Text(
                  _formatRupiah(_total),
                  style: const TextStyle(
                    fontFamily: AppTheme.fontDisplay,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primaryDeep,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          SizedBox(
            width: double.infinity,
            child: GradientButton(
              label: 'KONFIRMASI PESANAN',
              leadingIcon: Icons.check_circle_outline,
              onPressed: _showConfirmationDialog,
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // BODY
  // =========================================================

  Widget _buildBody(List<Map<String, dynamic>> cart) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= Breakpoints.wide;

        if (isWide) {
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: Breakpoints.maxContent,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(32, 4, 32, 32),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _formSections(),
                        ),
                      ),
                    ),

                    const SizedBox(width: 28),

                    SizedBox(
                      width: 380,
                      child: SingleChildScrollView(child: _summaryCard(cart)),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return ResponsiveCenter(
          maxWidth: 720,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ..._formSections(),

                const SizedBox(height: 20),

                _summaryCard(cart),
              ],
            ),
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

      appBar: AppBar(title: const Text('Checkout')),

      body: ValueListenableBuilder<List<Map<String, dynamic>>>(
        valueListenable: AppData.cart,
        builder: (context, cart, child) {
          if (cart.isEmpty) {
            return _buildEmptyCart();
          }

          return _buildBody(cart);
        },
      ),
    );
  }

  // =========================================================
  // KERANJANG KOSONG
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
              decoration: const BoxDecoration(
                color: AppTheme.softPink,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.shopping_bag_outlined,
                size: 55,
                color: AppTheme.primary,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Keranjang masih kosong',
              style: TextStyle(
                fontFamily: AppTheme.fontDisplay,
                fontSize: 21,
                fontWeight: FontWeight.w600,
                color: AppTheme.cocoa,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Tambahkan Mochi favoritmu terlebih dahulu.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppTheme.cocoa.withValues(alpha: 0.8)),
            ),

            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('KEMBALI'),
            ),
          ],
        ),
      ),
    );
  }
}
