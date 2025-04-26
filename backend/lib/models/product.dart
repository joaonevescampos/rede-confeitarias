class Product {
  final int store_id;
  final String product_name;
  final double price;
  final String description;
  final String image_url;

  Product({
    required this.store_id,
    required this.product_name,
    required this.price,
    required this.description,
    required this.image_url,
  });

  Map<String, dynamic> toMap() {
    return {
      'store_id': store_id,
      'product_name': product_name,
      'price': price,
      'description': description,
      'image_url': image_url,
    };
  }
}
