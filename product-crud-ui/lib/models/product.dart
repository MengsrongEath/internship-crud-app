class Product {
  final int? productId;
  final String productName;
  final double price;
  final int stock;

  Product({
    this.productId,
    required this.productName,
    required this.price,
    required this.stock,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['PRODUCTID'] as int?,
      productName: json['PRODUCTNAME'] as String,
      price: (json['PRICE'] as num).toDouble(),
      stock: json['STOCK'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productName': productName,
      'price': price,
      'stock': stock,
    };
  }

  Product copyWith({
    int? productId,
    String? productName,
    double? price,
    int? stock,
  }) {
    return Product(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      price: price ?? this.price,
      stock: stock ?? this.stock,
    );
  }

  @override
  String toString() {
    return 'Product{productId: $productId, productName: $productName, price: $price, stock: $stock}';
  }
}