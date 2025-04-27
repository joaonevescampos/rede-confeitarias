import 'package:rede_confeitarias/models/product_model.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;
  ProductLoaded(this.products);
}

class ProductSingleLoaded extends ProductState {
  final Product product;
  ProductSingleLoaded(this.product);
}

class ProductError extends ProductState {
  final String message;
  ProductError(this.message);
}
