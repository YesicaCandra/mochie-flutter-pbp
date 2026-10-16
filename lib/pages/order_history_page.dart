import 'package:flutter/material.dart';

import '../app_data.dart';
import '../theme/app_theme.dart';
import '../widgets/app_snackbar.dart';
import '../widgets/gradient_button.dart';
import '../widgets/mochi_image.dart';
import '../widgets/responsive.dart';

class OrderHistoryPage extends StatefulWidget {
  final bool showSuccessMessage;

  const OrderHistoryPage({super.key, this.showSuccessMessage = false});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  // ===========================================================
  // DAFTAR STATUS PESANAN
  // ===========================================================

  final List<String> orderStatuses = [
    'Pesanan dibuat',
    'Sedang diproses',
    'Sedang dikirim',
    'Pesanan selesai',
  ];

  // Label singkat untuk stepper.
  final List<String> _shortLabels = [
    'Dibuat',
    'Diproses',
    'Dikirim',
    'Selesai',
  ];

  // ===========================================================
  // SUCCESS MESSAGE
  // ===========================================================

  @override
  void initState() {
    super.initState();

    if (widget.showSuccessMessage) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;

        AppSnackBar.success(context, 'Pesanan berhasil dibuat! 🎉');
      });
    }
  }

  // ===========================================================
  // FORMAT RUPIAH
  // ===========================================================

  String _formatRupiah(dynamic value) {
    final number = (value as num?)?.toInt() ?? 0;

    final numberString = number.toString();

    String result = '';

    for (int i = 0; i < numberString.length; i++) {
      if (i > 0 && (numberString.length - i) % 3 == 0) {
        result += '.';
      }

      result += numberString[i];
    }

    return 'Rp$result';
  }

  // ===========================================================
  // FORMAT TANGGAL
  // Memakai order['date'] jika ada. Jika tidak, tanggal dibaca dari
  // orderId (format MOCHI-<waktu dalam milidetik>).
  // ===========================================================

  String _formatDate(Map<String, dynamic> order) {
    DateTime? date;

    final dateValue = order['date'];

    if (dateValue is DateTime) {
      date = dateValue;
    } else {
      final match = RegExp(r'(\d{10,})')
          .firstMatch(order['orderId']?.toString() ?? '');

      if (match != null) {
        final millis = int.tryParse(match.group(1)!);

        if (millis != null) {
          date = DateTime.fromMillisecondsSinceEpoch(millis);
        }
      }
    }

    if (date == null) {
      return '-';
    }

    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');

    return '$day/$month/$year • $hour:$minute';
  }

  // ===========================================================
  // TOTAL QUANTITY
  // ===========================================================

  int _getTotalQuantity(List<Map<String, dynamic>> items) {
    int total = 0;

    for (final item in items) {
      total += (item['quantity'] ?? 1) as int;
    }

    return total;
  }

  // ===========================================================
  // STATUS
  // ===========================================================

  int _getStatusIndex(String status) {
    final index = orderStatuses.indexOf(status);

    if (index == -1) {
      return 0;
    }

    return index;
  }

  Color _statusBackground(String status) {
    if (status == 'Pesanan selesai') {
      return AppTheme.mint;
    }

    return AppTheme.yellow;
  }

  // ===========================================================
  // UPDATE STATUS
  // ===========================================================

  void _updateStatus(int orderIndex, Map<String, dynamic> order) {
    final currentStatus = order['status']?.toString() ?? 'Pesanan dibuat';

    final currentIndex = _getStatusIndex(currentStatus);

    if (currentIndex >= orderStatuses.length - 1) {
      return;
    }

    final nextStatus = orderStatuses[currentIndex + 1];

    AppData.updateOrderStatus(orderIndex, nextStatus);

    AppSnackBar.success(context, 'Status diperbarui menjadi "$nextStatus"');
  }

  // ===========================================================
  // ITEM PESANAN
  // ===========================================================

  Widget _orderItem(Map<String, dynamic> item) {
    final name = item['name']?.toString() ?? '-';

    final price = item['price']?.toString() ?? 'Rp0';

    final quantity = item['quantity'] ?? 1;

    final image = item['image']?.toString() ?? '';

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppTheme.cream,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          MochiImage(path: image, width: 48, height: 48, borderRadius: 12),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.cocoa,
                  ),
                ),

                Text(
                  '$price × $quantity',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.cocoa.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================
  // BARIS DETAIL
  // ===========================================================

  Widget _detailRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: AppTheme.primaryDeep),

          const SizedBox(width: 10),

          SizedBox(
            width: 84,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppTheme.cocoa.withValues(alpha: 0.8),
              ),
            ),
          ),

          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: AppTheme.cocoa,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================
  // STEPPER STATUS
  // ===========================================================

  Widget _statusTimeline(String currentStatus) {
    final currentIndex = _getStatusIndex(currentStatus);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.cream,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Status Pesanan',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: AppTheme.cocoa,
            ),
          ),

          const SizedBox(height: 10),

          Row(
            children: List.generate(orderStatuses.length, (index) {
              final isDone = index <= currentIndex;

              return Expanded(
                child: Column(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(
                        color: isDone ? AppTheme.mint : AppTheme.softPink,
                        shape: BoxShape.circle,
                      ),
                      child: isDone
                          ? const Icon(
                              Icons.check_rounded,
                              size: 16,
                              color: AppTheme.cocoa,
                            )
                          : null,
                    ),

                    const SizedBox(height: 4),

                    Text(
                      _shortLabels[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w800,
                        color: isDone
                            ? AppTheme.cocoa
                            : AppTheme.cocoa.withValues(alpha: 0.65),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  // ===========================================================
  // KARTU PESANAN
  // ===========================================================

  Widget _orderCard(Map<String, dynamic> order, int orderIndex) {
    final items =
        (order['items'] as List?)
            ?.map((item) => Map<String, dynamic>.from(item as Map))
            .toList() ??
        [];

    final customerName = order['customerName']?.toString() ?? '-';

    final phone = order['phone']?.toString() ?? '-';

    final address = order['address']?.toString() ?? '-';

    final shipping = order['shippingMethod']?.toString() ?? '-';

    final payment = order['paymentMethod']?.toString() ?? '-';

    final status = order['status']?.toString() ?? 'Pesanan dibuat';

    final subtotal = order['subtotal'] ?? 0;

    final shippingCost = order['shippingCost'] ?? 0;

    final total = order['total'] ?? 0;

    final totalQuantity = _getTotalQuantity(items);

    final isFinished = _getStatusIndex(status) == orderStatuses.length - 1;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppTheme.cocoa.withValues(alpha: 0.07),
            blurRadius: 18,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADER
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Pesanan Mochi',
                      style: TextStyle(
                        fontFamily: AppTheme.fontDisplay,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.cocoa,
                      ),
                    ),

                    Text(
                      '${_formatDate(order)} • $totalQuantity item',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.cocoa.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: _statusBackground(status),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  status,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.cocoa,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // ITEM
          ...items.map((item) => _orderItem(item)),

          const SizedBox(height: 6),

          // STATUS
          _statusTimeline(status),

          const SizedBox(height: 12),

          // UPDATE STATUS
          SizedBox(
            width: double.infinity,
            child: isFinished
                ? Container(
                    height: 46,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppTheme.mintSoft,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          size: 20,
                          color: AppTheme.cocoa,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'PESANAN SELESAI',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.cocoa,
                          ),
                        ),
                      ],
                    ),
                  )
                : GradientButton(
                    label: 'UPDATE STATUS (SIMULASI)',
                    height: 46,
                    fontSize: 13,
                    onPressed: () {
                      _updateStatus(orderIndex, order);
                    },
                  ),
          ),

          const SizedBox(height: 16),

          // DETAIL PENGIRIMAN
          const Text(
            'Detail Pengiriman',
            style: TextStyle(
              fontFamily: AppTheme.fontDisplay,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppTheme.cocoa,
            ),
          ),

          const SizedBox(height: 10),

          _detailRow(Icons.person_outline, 'Nama', customerName),

          _detailRow(Icons.phone_outlined, 'Nomor HP', phone),

          _detailRow(Icons.location_on_outlined, 'Alamat', address),

          _detailRow(Icons.local_shipping_outlined, 'Pengiriman', shipping),

          _detailRow(Icons.credit_card_outlined, 'Pembayaran', payment),

          const Divider(color: AppTheme.softPink, height: 20),

          // RINGKASAN PEMBAYARAN
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Subtotal',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.cocoa.withValues(alpha: 0.8),
                ),
              ),
              Text(
                _formatRupiah(subtotal),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.cocoa,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Pengiriman',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.cocoa.withValues(alpha: 0.8),
                ),
              ),
              Text(
                _formatRupiah(shippingCost),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.cocoa,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: AppTheme.dustyRose,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.cocoa,
                  ),
                ),
                Text(
                  _formatRupiah(total),
                  style: const TextStyle(
                    fontFamily: AppTheme.fontDisplay,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.cocoa,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================
  // KOSONG
  // ===========================================================

  Widget _emptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35),
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
                Icons.receipt_long_outlined,
                size: 46,
                color: AppTheme.primary,
              ),
            ),

            const SizedBox(height: 22),

            const Text(
              'Belum Ada Pesanan',
              style: TextStyle(
                fontFamily: AppTheme.fontDisplay,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppTheme.cocoa,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Pesanan yang sudah kamu buat akan muncul di sini.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: AppTheme.cocoa.withValues(alpha: 0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================
  // BUILD
  // ===========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.cream,

      appBar: AppBar(title: const Text('Order History')),

      body: ValueListenableBuilder<List<Map<String, dynamic>>>(
        valueListenable: AppData.orderHistory,
        builder: (context, orders, child) {
          if (orders.isEmpty) {
            return _emptyState();
          }

          return ResponsiveCenter(
            maxWidth: 760,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];

                return _orderCard(order, index);
              },
            ),
          );
        },
      ),
    );
  }
}
