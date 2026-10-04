import 'mochi.dart';

// Getter dan setter sengaja digunakan karena model ini
// merupakan bagian dari implementasi konsep PBO.

// ignore_for_file: prefer_initializing_formals

class CartItem {
  // =========================================================
  // ATTRIBUTE / FIELD
  // =========================================================

  Mochi _mochi;
  int _quantity;

  // =========================================================
  // CONSTRUCTOR
  // =========================================================

  CartItem({required Mochi mochi, int quantity = 1})
    : _mochi = mochi,
      _quantity = quantity;

  // =========================================================
  // GETTER
  // =========================================================

  Mochi get mochi {
    return _mochi;
  }

  int get quantity {
    return _quantity;
  }

  // =========================================================
  // SETTER
  // =========================================================

  set mochi(Mochi value) {
    if (value.name.trim().isNotEmpty) {
      _mochi = value;
    }
  }

  set quantity(int value) {
    if (value >= 1) {
      _quantity = value;
    }
  }

  // =========================================================
  // METHOD / FUNCTION
  // =========================================================

  void increaseQuantity() {
    _quantity++;
  }

  void decreaseQuantity() {
    if (_quantity > 1) {
      _quantity--;
    }
  }

  double getTotalPrice() {
    final priceText = _mochi.price
        .replaceAll('Rp', '')
        .replaceAll('.', '')
        .replaceAll(',', '')
        .trim();

    final price = double.tryParse(priceText) ?? 0;

    return price * _quantity;
  }

  // =========================================================
  // OBJECT → MAP
  // =========================================================

  Map<String, dynamic> toMap() {
    return {..._mochi.toMap(), 'quantity': _quantity};
  }
}
