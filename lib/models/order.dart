// Model Order untuk menyimpan data pesanan.
// Menggunakan konsep PBO:
// Class, Attribute, Constructor, Getter, Setter,
// Method, toMap(), dan fromMap().

// ignore_for_file: prefer_initializing_formals

class Order {
  String _orderId;
  String _customerName;
  String _phone;
  String _address;
  String _shippingMethod;
  String _paymentMethod;
  double _subtotal;
  double _shippingCost;
  double _total;
  String _status;

  // Menyimpan semua produk yang dibeli
  List<Map<String, dynamic>> _items;

  // =========================================================
  // CONSTRUCTOR
  // =========================================================

  Order({
    required String orderId,
    required String customerName,
    required String phone,
    required String address,
    required String shippingMethod,
    required String paymentMethod,
    required double subtotal,
    required double shippingCost,
    required double total,
    List<Map<String, dynamic>> items = const [],
    String status = 'Pesanan dibuat',
  }) : _orderId = orderId,
       _customerName = customerName,
       _phone = phone,
       _address = address,
       _shippingMethod = shippingMethod,
       _paymentMethod = paymentMethod,
       _subtotal = subtotal,
       _shippingCost = shippingCost,
       _total = total,
       _items = List<Map<String, dynamic>>.from(items),
       _status = status;

  // =========================================================
  // GETTER
  // =========================================================

  String get orderId {
    return _orderId;
  }

  String get customerName {
    return _customerName;
  }

  String get phone {
    return _phone;
  }

  String get address {
    return _address;
  }

  String get shippingMethod {
    return _shippingMethod;
  }

  String get paymentMethod {
    return _paymentMethod;
  }

  double get subtotal {
    return _subtotal;
  }

  double get shippingCost {
    return _shippingCost;
  }

  double get total {
    return _total;
  }

  String get status {
    return _status;
  }

  List<Map<String, dynamic>> get items {
    return List<Map<String, dynamic>>.from(_items);
  }

  // =========================================================
  // GETTER JUMLAH ITEM
  // =========================================================

  int get itemCount {
    int totalQuantity = 0;

    for (final item in _items) {
      final quantity = item['quantity'];

      if (quantity is num) {
        totalQuantity += quantity.toInt();
      } else {
        totalQuantity += 1;
      }
    }

    return totalQuantity;
  }

  // =========================================================
  // SETTER
  // =========================================================

  set orderId(String value) {
    if (value.trim().isNotEmpty) {
      _orderId = value;
    }
  }

  set customerName(String value) {
    if (value.trim().isNotEmpty) {
      _customerName = value;
    }
  }

  set phone(String value) {
    if (value.trim().isNotEmpty) {
      _phone = value;
    }
  }

  set address(String value) {
    if (value.trim().isNotEmpty) {
      _address = value;
    }
  }

  set shippingMethod(String value) {
    if (value.trim().isNotEmpty) {
      _shippingMethod = value;
    }
  }

  set paymentMethod(String value) {
    if (value.trim().isNotEmpty) {
      _paymentMethod = value;
    }
  }

  set subtotal(double value) {
    if (value >= 0) {
      _subtotal = value;
    }
  }

  set shippingCost(double value) {
    if (value >= 0) {
      _shippingCost = value;
    }
  }

  set total(double value) {
    if (value >= 0) {
      _total = value;
    }
  }

  set status(String value) {
    if (value.trim().isNotEmpty) {
      _status = value;
    }
  }

  set items(List<Map<String, dynamic>> value) {
    _items = List<Map<String, dynamic>>.from(value);
  }

  // =========================================================
  // METHOD UPDATE STATUS
  // =========================================================

  void updateStatus(String newStatus) {
    if (newStatus.trim().isNotEmpty) {
      _status = newStatus;
    }
  }

  // =========================================================
  // METHOD CEK PESANAN SELESAI
  // =========================================================

  bool isCompleted() {
    return _status == 'Pesanan selesai';
  }

  // =========================================================
  // METHOD TOTAL
  // =========================================================

  String getTotalLabel() {
    return 'Total: Rp${_total.toStringAsFixed(0)}';
  }

  // =========================================================
  // OBJECT -> MAP
  // =========================================================

  Map<String, dynamic> toMap() {
    return {
      'orderId': _orderId,
      'customerName': _customerName,
      'phone': _phone,
      'address': _address,
      'shippingMethod': _shippingMethod,
      'paymentMethod': _paymentMethod,
      'subtotal': _subtotal,
      'shippingCost': _shippingCost,
      'total': _total,
      'status': _status,

      // SEMUA PRODUK YANG DIBELI
      'items': List<Map<String, dynamic>>.from(_items),

      // TOTAL JUMLAH PRODUK
      'itemCount': itemCount,
    };
  }

  // =========================================================
  // MAP -> OBJECT
  // =========================================================

  factory Order.fromMap(Map<String, dynamic> map) {
    List<Map<String, dynamic>> parsedItems = [];

    final rawItems = map['items'];

    if (rawItems is List) {
      parsedItems = rawItems
          .whereType<Map>()
          .map((item) => Map<String, dynamic>.from(item))
          .toList();
    }

    return Order(
      orderId: (map['orderId'] ?? '').toString(),

      customerName: (map['customerName'] ?? 'Pelanggan').toString(),

      phone: (map['phone'] ?? '-').toString(),

      address: (map['address'] ?? '-').toString(),

      shippingMethod: (map['shippingMethod'] ?? 'Reguler').toString(),

      paymentMethod: (map['paymentMethod'] ?? 'COD').toString(),

      subtotal: (map['subtotal'] as num?)?.toDouble() ?? 0,

      shippingCost: (map['shippingCost'] as num?)?.toDouble() ?? 0,

      total: (map['total'] as num?)?.toDouble() ?? 0,

      status: (map['status'] ?? 'Pesanan dibuat').toString(),

      // PRODUK
      items: parsedItems,
    );
  }
}
