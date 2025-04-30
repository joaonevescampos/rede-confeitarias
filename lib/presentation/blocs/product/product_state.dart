import 'package:rede_confeitarias/models/product_model.dart';
import 'package:equatable/equatable.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;
   final Product? product; // Também pode ser uma loja específica carregada

  const ProductLoaded({this.products = const [], this.product});

  @override
  List<Object?> get props => [products, product];
}

// class ProductSingleLoaded extends ProductState {
//   final Product product;
//   ProductSingleLoaded(this.product);
// }

class ProductError extends ProductState {
  final String message;
  const ProductError(this.message);

  @override
  List<Object?> get props => [message];
}
