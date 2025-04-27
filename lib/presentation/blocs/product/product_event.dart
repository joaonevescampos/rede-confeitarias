import 'package:rede_confeitarias/models/product_model.dart';

abstract class ProductEvent {}

class GetProductsByStoreIdEvent extends ProductEvent {
  final int storeId;
  GetProductsByStoreIdEvent(this.storeId);
}

class GetProductByIdEvent extends ProductEvent {
  final int productId;
  GetProductByIdEvent(this.productId);
}

class CreateProductEvent extends ProductEvent {
  final Product product;
  CreateProductEvent(this.product);
}

class DeleteProductEvent extends ProductEvent {
  final int productId;
  DeleteProductEvent(this.productId);
}

class UpdateProductEvent extends ProductEvent {
  final Product product;
  UpdateProductEvent(this.product);
}
