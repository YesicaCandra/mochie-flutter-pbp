import 'package:flutter/material.dart';

import '../app_data.dart';
import '../theme/app_theme.dart';

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

  // ===========================================================
  // SUCCESS MESSAGE
  // ===========================================================

  @override
  void initState() {
    super.initState();

    if (widget.showSuccessMessage) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.check_circle_outline, color: AppTheme.white),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Pesanan berhasil dibuat! 🎉',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: AppTheme.darkPlum,
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            duration: const Duration(seconds: 3),
          ),
        );
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
  // FORMAT DATE
  // ===========================================================

  String _formatDate(dynamic dateValue) {
    if (dateValue is! DateTime) {
      return '-';
    }

    final day = dateValue.day.toString().padLeft(2, '0');

    final month = dateValue.month.toString().padLeft(2, '0');

    final year = dateValue.year.toString();

    final hour = dateValue.hour.toString().padLeft(2, '0');

    final minute = dateValue.minute.toString().padLeft(2, '0');

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
  // STATUS INDEX
  // ===========================================================

  int _getStatusIndex(String status) {
    final index = orderStatuses.indexOf(status);

    if (index == -1) {
      return 0;
    }

    return index;
  }

  // ===========================================================
  // STATUS BACKGROUND
  // ===========================================================

  Color _statusBackground(String status) {
    if (status == 'Pesanan selesai') {
      return AppTheme.dustyRose;
    }

    return AppTheme.softPink;
  }

  // ===========================================================
  // STATUS ICON
  // ===========================================================

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'Pesanan dibuat':
        return Icons.receipt_long_outlined;

      case 'Sedang diproses':
        return Icons.settings_outlined;

      case 'Sedang dikirim':
        return Icons.local_shipping_outlined;

      case 'Pesanan selesai':
        return Icons.check_circle_outline;

      default:
        return Icons.receipt_long_outlined;
    }
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

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_outline, color: AppTheme.white),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Status diperbarui menjadi "$nextStatus"',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppTheme.darkPlum,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // ===========================================================
  // ORDER ITEM
  // ===========================================================

  Widget _orderItem(Map<String, dynamic> item) {
    final name = item['name']?.toString() ?? '-';

    final price = item['price']?.toString() ?? 'Rp0';

    final quantity = item['quantity'] ?? 1;

    final image = item['image']?.toString() ?? '';

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppTheme.cream,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // =====================================================
          // IMAGE
          // =====================================================

          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              image,
              width: 58,
              height: 58,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 58,
                  height: 58,
                  color: AppTheme.softPink,
                  child: const Icon(
                    Icons.image_not_supported_outlined,
                    color: AppTheme.dustyRoseDark,
                  ),
                );
              },
            ),
          ),

          const SizedBox(width: 12),

          // =====================================================
          // NAME
          // =====================================================
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
                    fontWeight: FontWeight.bold,
                    color: AppTheme.darkPlum,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  '$price × $quantity',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.darkPlum.withValues(alpha: 0.55),
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
  // DETAIL ROW
  // ===========================================================

  Widget _detailRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 19, color: AppTheme.dustyRoseDark),

          const SizedBox(width: 10),

          SizedBox(
            width: 90,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: AppTheme.darkPlum.withValues(alpha: 0.55),
              ),
            ),
          ),

          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppTheme.darkPlum,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================
  // STATUS TIMELINE
  // ===========================================================

  Widget _statusTimeline(String currentStatus) {
    final currentIndex = _getStatusIndex(currentStatus);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
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
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppTheme.darkPlum,
            ),
          ),

          const SizedBox(height: 16),

          ...List.generate(orderStatuses.length, (index) {
            final isCompleted = index <= currentIndex;

            final isCurrent = index == currentIndex;

            final isLast = index == orderStatuses.length - 1;

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // =================================================
                // TIMELINE LEFT
                // =================================================

                SizedBox(
                  width: 28,
                  child: Column(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: isCurrent ? 24 : 20,
                        height: isCurrent ? 24 : 20,
                        decoration: BoxDecoration(
                          color: isCompleted
                              ? AppTheme.dustyRoseDark
                              : AppTheme.softPink,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isCompleted
                                ? AppTheme.dustyRoseDark
                                : AppTheme.dustyRose,
                            width: 1.5,
                          ),
                        ),
                        child: Icon(
                          isCompleted ? Icons.check : Icons.circle,
                          size: isCurrent ? 14 : 7,
                          color: isCompleted
                              ? AppTheme.white
                              : AppTheme.dustyRoseDark,
                        ),
                      ),

                      if (!isLast)
                        Container(
                          width: 2,
                          height: 34,
                          color: index < currentIndex
                              ? AppTheme.dustyRoseDark
                              : AppTheme.dustyRose,
                        ),
                    ],
                  ),
                ),

                const SizedBox(width: 10),

                // =================================================
                // STATUS TEXT
                // =================================================
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          orderStatuses[index],
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: isCurrent || isCompleted
                                ? FontWeight.bold
                                : FontWeight.w500,
                            color: isCompleted
                                ? AppTheme.darkPlum
                                : AppTheme.darkPlum.withValues(alpha: 0.40),
                          ),
                        ),

                        if (isCurrent)
                          Padding(
                            padding: const EdgeInsets.only(top: 3, bottom: 14),
                            child: Row(
                              children: [
                                Icon(
                                  _getStatusIcon(orderStatuses[index]),
                                  size: 13,
                                  color: AppTheme.dustyRoseDark,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  'Status saat ini',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: AppTheme.dustyRoseDark,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          )
                        else
                          const SizedBox(height: 14),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  // ===========================================================
  // ORDER CARD
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

    final date = order['date'];

    final totalQuantity = _getTotalQuantity(items);

    final currentStatusIndex = _getStatusIndex(status);

    final isFinished = currentStatusIndex == orderStatuses.length - 1;

    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppTheme.dustyRoseDark.withValues(alpha: 0.10),
            blurRadius: 18,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // =====================================================
          // HEADER ORDER
          // =====================================================

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
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.darkPlum,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      _formatDate(date),
                      style: TextStyle(
                        fontSize: 11,
                        color: AppTheme.darkPlum.withValues(alpha: 0.50),
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
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isFinished
                          ? Icons.check_circle_outline
                          : Icons.radio_button_checked,
                      size: 14,
                      color: AppTheme.darkPlum,
                    ),

                    const SizedBox(width: 5),

                    Text(
                      status,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.darkPlum,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          // =====================================================
          // ITEM COUNT
          // =====================================================
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
            decoration: BoxDecoration(
              color: AppTheme.cream,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.shopping_bag_outlined,
                  size: 18,
                  color: AppTheme.dustyRoseDark,
                ),

                const SizedBox(width: 8),

                Text(
                  '$totalQuantity item',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.darkPlum,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // =====================================================
          // ITEMS
          // =====================================================
          if (items.isNotEmpty) ...items.map((item) => _orderItem(item)),

          const SizedBox(height: 6),

          const Divider(color: AppTheme.softPink, height: 20),

          // =====================================================
          // STATUS TIMELINE
          // =====================================================
          _statusTimeline(status),

          const SizedBox(height: 14),

          // =====================================================
          // UPDATE STATUS BUTTON
          // =====================================================
          SizedBox(
            width: double.infinity,
            height: 46,
            child: ElevatedButton.icon(
              onPressed: isFinished
                  ? null
                  : () {
                      _updateStatus(orderIndex, order);
                    },
              icon: Icon(
                isFinished ? Icons.check_circle_outline : Icons.sync_rounded,
                size: 19,
              ),
              label: Text(
                isFinished ? 'PESANAN SELESAI' : 'UPDATE STATUS',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.3,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: isFinished
                    ? AppTheme.dustyRose
                    : AppTheme.darkPlum,
                disabledBackgroundColor: AppTheme.dustyRose,
                foregroundColor: isFinished
                    ? AppTheme.darkPlum
                    : AppTheme.white,
                disabledForegroundColor: AppTheme.darkPlum,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          const Divider(color: AppTheme.softPink, height: 20),

          // =====================================================
          // CUSTOMER DETAIL
          // =====================================================
          const Text(
            'Detail Pengiriman',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppTheme.darkPlum,
            ),
          ),

          const SizedBox(height: 14),

          _detailRow(Icons.person_outline, 'Nama', customerName),

          _detailRow(Icons.phone_outlined, 'Nomor HP', phone),

          _detailRow(Icons.location_on_outlined, 'Alamat', address),

          _detailRow(Icons.local_shipping_outlined, 'Pengiriman', shipping),

          _detailRow(Icons.credit_card_outlined, 'Pembayaran', payment),

          const Divider(color: AppTheme.softPink, height: 20),

          // =====================================================
          // PAYMENT SUMMARY
          // =====================================================
          const Text(
            'Ringkasan Pembayaran',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppTheme.darkPlum,
            ),
          ),

          const SizedBox(height: 14),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Subtotal',
                style: TextStyle(
                  fontSize: 12,
                  color: AppTheme.darkPlum.withValues(alpha: 0.55),
                ),
              ),
              Text(
                _formatRupiah(subtotal),
                style: const TextStyle(fontSize: 12, color: AppTheme.darkPlum),
              ),
            ],
          ),

          const SizedBox(height: 9),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Pengiriman',
                style: TextStyle(
                  fontSize: 12,
                  color: AppTheme.darkPlum.withValues(alpha: 0.55),
                ),
              ),
              Text(
                _formatRupiah(shippingCost),
                style: const TextStyle(fontSize: 12, color: AppTheme.darkPlum),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
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
                    fontWeight: FontWeight.bold,
                    color: AppTheme.darkPlum,
                  ),
                ),
                Text(
                  _formatRupiah(total),
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
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

  // ===========================================================
  // EMPTY STATE
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
              child: const Center(
                child: Text('🧾', style: TextStyle(fontSize: 45)),
              ),
            ),

            const SizedBox(height: 22),

            const Text(
              'Belum Ada Pesanan',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.darkPlum,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Pesanan yang sudah kamu buat akan muncul di sini.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: AppTheme.darkPlum.withValues(alpha: 0.55),
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

      appBar: AppBar(
        title: const Text(
          'Order History',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: ValueListenableBuilder<List<Map<String, dynamic>>>(
        valueListenable: AppData.orderHistory,
        builder: (context, orders, child) {
          if (orders.isEmpty) {
            return _emptyState();
          }

          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];

              return _orderCard(order, index);
            },
          );
        },
      ),
    );
  }
}
