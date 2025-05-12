class Product {
  final int? id;
  final int? storeId;
  final String productName;
  final double price;
  final String description;
  final String imageUrl;

  Product({
    this.id,
    this.storeId,
    required this.productName,
    required this.price,
    required this.description,
    required this.imageUrl,
  });

  // Converte o objeto Product para um Map
Map<String, dynamic> toJson() {
  final map = {
    'storeId': storeId,
    'productName': productName,
    'price': price,
    'description': description,
    'imageUrl': imageUrl,
  };

  if (id != null) {
    map['id'] = id!;
  }

  return map;
}


  // Converte um Map para o objeto Product
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      storeId: json['storeId'],
      productName: json['productName'],
      price: json['price'],
      description: json['description'],
      imageUrl: json['imageUrl'],
    );
  }
}
