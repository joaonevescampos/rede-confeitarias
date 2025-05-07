class Product {
  final int storeId;
  final String productName;
  final double price;
  final String description;
  final String imageUrl;

  Product({
    required this.storeId,
    required this.productName,
    required this.price,
    required this.description,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'storeId': storeId,
      'productName': productName,
      'price': price,
      'description': description,
      'imageUrl': imageUrl,
    };
  }
}
