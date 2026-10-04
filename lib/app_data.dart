import 'package:flutter/foundation.dart';

import 'models/cart_item.dart';
import 'models/mochi.dart';
import 'models/order.dart';

class AppData {
  // =========================================================
  // FAVORITE
  // =========================================================

  static final ValueNotifier<List<Map<String, dynamic>>> favorites =
      ValueNotifier<List<Map<String, dynamic>>>([]);

  // =========================================================
  // CART
  // =========================================================

  static final ValueNotifier<List<Map<String, dynamic>>> cart =
      ValueNotifier<List<Map<String, dynamic>>>([]);

  // =========================================================
  // ORDER HISTORY
  // =========================================================

  static final ValueNotifier<List<Map<String, dynamic>>> orderHistory =
      ValueNotifier<List<Map<String, dynamic>>>([]);

  // =========================================================
  // CHECK FAVORITE
  // =========================================================

  static bool isFavorite(String name) {
    return favorites.value.any((item) => item['name'] == name);
  }

  // =========================================================
  // TOGGLE FAVORITE
  // =========================================================

  static void toggleFavorite(Map<String, dynamic> mochi) {
    final updatedFavorites = List<Map<String, dynamic>>.from(favorites.value);

    final index = updatedFavorites.indexWhere(
      (item) => item['name'] == mochi['name'],
    );

    if (index >= 0) {
      updatedFavorites.removeAt(index);
    } else {
      final mochiObject = Mochi.fromMap(mochi);

      updatedFavorites.add(mochiObject.toMap());
    }

    favorites.value = updatedFavorites;
  }

  // =========================================================
  // ADD TO CART
  // =========================================================

  static void addToCart(Map<String, dynamic> mochi) {
    final updatedCart = List<Map<String, dynamic>>.from(cart.value);

    final index = updatedCart.indexWhere(
      (item) => item['name'] == mochi['name'],
    );

    if (index >= 0) {
      final cartItem = CartItem(
        mochi: Mochi.fromMap(updatedCart[index]),
        quantity: updatedCart[index]['quantity'] ?? 1,
      );

      cartItem.increaseQuantity();

      updatedCart[index] = cartItem.toMap();
    } else {
      final mochiObject = Mochi.fromMap(mochi);

      final cartItem = CartItem(mochi: mochiObject);

      updatedCart.add(cartItem.toMap());
    }

    cart.value = updatedCart;
  }

  // =========================================================
  // INCREASE QUANTITY
  // =========================================================

  static void increaseQuantity(String name) {
    final updatedCart = List<Map<String, dynamic>>.from(cart.value);

    final index = updatedCart.indexWhere((item) => item['name'] == name);

    if (index >= 0) {
      final cartItem = CartItem(
        mochi: Mochi.fromMap(updatedCart[index]),
        quantity: updatedCart[index]['quantity'] ?? 1,
      );

      cartItem.increaseQuantity();

      updatedCart[index] = cartItem.toMap();
    }

    cart.value = updatedCart;
  }

  // =========================================================
  // DECREASE QUANTITY
  // =========================================================

  static void decreaseQuantity(String name) {
    final updatedCart = List<Map<String, dynamic>>.from(cart.value);

    final index = updatedCart.indexWhere((item) => item['name'] == name);

    if (index >= 0) {
      final cartItem = CartItem(
        mochi: Mochi.fromMap(updatedCart[index]),
        quantity: updatedCart[index]['quantity'] ?? 1,
      );

      final oldQuantity = cartItem.quantity;

      cartItem.decreaseQuantity();

      if (oldQuantity == 1) {
        updatedCart.removeAt(index);
      } else {
        updatedCart[index] = cartItem.toMap();
      }
    }

    cart.value = updatedCart;
  }

  // =========================================================
  // REMOVE FROM CART
  // =========================================================

  static void removeFromCart(String name) {
    final updatedCart = List<Map<String, dynamic>>.from(cart.value);

    updatedCart.removeWhere((item) => item['name'] == name);

    cart.value = updatedCart;
  }

  // =========================================================
  // CLEAR CART
  // =========================================================

  static void clearCart() {
    cart.value = [];
  }

  // =========================================================
  // GET CART TOTAL
  // =========================================================

  static double getCartTotal() {
    double total = 0;

    for (final item in cart.value) {
      final cartItem = CartItem(
        mochi: Mochi.fromMap(item),
        quantity: item['quantity'] ?? 1,
      );

      total += cartItem.getTotalPrice();
    }

    return total;
  }

  // =========================================================
  // ADD ORDER
  // =========================================================
  //
  // PERBAIKAN UTAMA:
  //
  // Saat checkout memanggil AppData.addOrder(),
  // isi Cart otomatis disalin ke dalam Order.
  //
  // Jadi checkout_page.dart tidak perlu dibongkar.
  // =========================================================

  static void addOrder(Map<String, dynamic> order) {
    final updatedOrders = List<Map<String, dynamic>>.from(orderHistory.value);

    // =======================================================
    // SALIN DATA PRODUK DARI CART
    // =======================================================

    List<Map<String, dynamic>> orderItems = [];

    // Jika checkout sudah mengirim items,
    // gunakan items tersebut.
    final rawItems = order['items'];

    if (rawItems is List) {
      orderItems = rawItems
          .whereType<Map>()
          .map((item) => Map<String, dynamic>.from(item))
          .toList();
    }

    // =======================================================
    // JIKA CHECKOUT BELUM MENGIRIM ITEMS
    // AMBIL LANGSUNG DARI CART
    // =======================================================

    if (orderItems.isEmpty && cart.value.isNotEmpty) {
      orderItems = cart.value
          .map((item) => Map<String, dynamic>.from(item))
          .toList();
    }

    // =======================================================
    // BUAT OBJECT ORDER
    // =======================================================

    final orderObject = Order(
      orderId: (order['orderId'] ?? '').toString(),

      customerName: (order['customerName'] ?? 'Pelanggan').toString(),

      phone: (order['phone'] ?? '-').toString(),

      address: (order['address'] ?? '-').toString(),

      shippingMethod: (order['shippingMethod'] ?? 'Reguler').toString(),

      paymentMethod: (order['paymentMethod'] ?? 'COD').toString(),

      subtotal: (order['subtotal'] as num?)?.toDouble() ?? 0,

      shippingCost: (order['shippingCost'] as num?)?.toDouble() ?? 0,

      total: (order['total'] as num?)?.toDouble() ?? 0,

      status: (order['status'] ?? 'Pesanan dibuat').toString(),

      // =====================================================
      // SIMPAN PRODUK
      // =====================================================
      items: orderItems,
    );

    // =======================================================
    // MASUKKAN ORDER TERBARU KE PALING ATAS
    // =======================================================

    updatedOrders.insert(0, orderObject.toMap());

    orderHistory.value = updatedOrders;
  }

  // =========================================================
  // UPDATE ORDER STATUS
  // =========================================================

  static void updateOrderStatus(int orderIndex, String newStatus) {
    final updatedOrders = List<Map<String, dynamic>>.from(orderHistory.value);

    if (orderIndex >= 0 && orderIndex < updatedOrders.length) {
      final orderObject = Order.fromMap(updatedOrders[orderIndex]);

      orderObject.updateStatus(newStatus);

      updatedOrders[orderIndex] = orderObject.toMap();
    }

    orderHistory.value = updatedOrders;
  }
}
