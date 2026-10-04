// class, attribute, constructor, getter, setter, dan method.

// ignore_for_file: prefer_initializing_formals

class Mochi {
  // =========================================================
  // ATTRIBUTE / FIELD
  // =========================================================

  String _name;
  String _description;
  String _detailDescription;
  String _price;
  double _rating;
  String _image;

  // =========================================================
  // CONSTRUCTOR
  // =========================================================

  Mochi({
    required String name,
    required String description,
    required String detailDescription,
    required String price,
    required double rating,
    required String image,
  }) : _name = name,
       _description = description,
       _detailDescription = detailDescription,
       _price = price,
       _rating = rating,
       _image = image;

  // =========================================================
  // GETTER
  // =========================================================

  String get name {
    return _name;
  }

  String get description {
    return _description;
  }

  String get detailDescription {
    return _detailDescription;
  }

  String get price {
    return _price;
  }

  double get rating {
    return _rating;
  }

  String get image {
    return _image;
  }

  // =========================================================
  // SETTER
  // =========================================================

  set name(String value) {
    if (value.trim().isNotEmpty) {
      _name = value;
    }
  }

  set description(String value) {
    if (value.trim().isNotEmpty) {
      _description = value;
    }
  }

  set detailDescription(String value) {
    if (value.trim().isNotEmpty) {
      _detailDescription = value;
    }
  }

  set price(String value) {
    if (value.trim().isNotEmpty) {
      _price = value;
    }
  }

  set rating(double value) {
    if (value >= 0 && value <= 5) {
      _rating = value;
    }
  }

  set image(String value) {
    if (value.trim().isNotEmpty) {
      _image = value;
    }
  }

  // =========================================================
  // METHOD / FUNCTION
  // =========================================================

  bool isHighlyRated() {
    return _rating >= 4.8;
  }

  String getPriceLabel() {
    return 'Harga: $_price';
  }

  String getRatingLabel() {
    return 'Rating: $_rating';
  }

  // =========================================================
  // OBJECT → MAP
  // =========================================================

  Map<String, dynamic> toMap() {
    return {
      'name': _name,
      'description': _description,
      'detailDescription': _detailDescription,
      'price': _price,
      'rating': _rating,
      'image': _image,
    };
  }

  // =========================================================
  // MAP → OBJECT
  // =========================================================

  factory Mochi.fromMap(Map<String, dynamic> map) {
    return Mochi(
      name: map['name'] as String,
      description: map['description'] as String,
      detailDescription: map['detailDescription'] as String,
      price: map['price'] as String,
      rating: (map['rating'] as num).toDouble(),
      image: map['image'] as String,
    );
  }
}
