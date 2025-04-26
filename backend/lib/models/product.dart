class Product {
  final String productName;
  final double price;
  final String description;
  final String imageUrl;

  Product({
    required this.productName,
    required this.price,
    required this.description,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'product_name': productName,
      'price': price,
      'description': description,
      'imageUrl': imageUrl,
    };
  }
}
