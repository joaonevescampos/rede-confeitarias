import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rede_confeitarias/presentation/blocs/product/product_event.dart';
import 'package:rede_confeitarias/presentation/blocs/product/product_state.dart';
import 'package:rede_confeitarias/repositories/product_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository;

  ProductBloc(this._productRepository) : super(ProductInitial()) {
    on<GetProductsByStoreIdEvent>(_onGetProductsByStoreId);
    on<GetProductByIdEvent>(_onGetProductById);
    on<CreateProductEvent>(_onCreateProduct);
    on<DeleteProductEvent>(_onDeleteProduct);
    on<UpdateProductEvent>(_onUpdateProduct);
  }

  // Função para listar os produtos de uma loja específica
  Future<void> _onGetProductsByStoreId(
    GetProductsByStoreIdEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    try {
      final products = await _productRepository.getProductsByStoreId(event.storeId);
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError('Erro ao carregar produtos'));
    }
  }

  // Função para listar um produto específico pelo ID
  Future<void> _onGetProductById(
    GetProductByIdEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    try {
      final product = await _productRepository.getProductById(event.productId);
      emit(ProductSingleLoaded(product));
    } catch (e) {
      emit(ProductError('Erro ao carregar produto'));
    }
  }

  // Função para criar um novo produto
  Future<void> _onCreateProduct(
    CreateProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    try {
      await _productRepository.createProduct(event.product);
      final products = await _productRepository.getProductsByStoreId(event.product.storeId); // atualiza lista
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError('Erro ao criar produto'));
    }
  }

  // Função para excluir um produto
  Future<void> _onDeleteProduct(
    DeleteProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    try {
      await _productRepository.deleteProduct(event.productId);
      final products = await _productRepository.getProductsByStoreId(event.productId); // atualiza lista
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError('Erro ao excluir produto'));
    }
  }

  // Função para editar um produto
  Future<void> _onUpdateProduct(
    UpdateProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    try {
      await _productRepository.updateProduct(event.product);
      final products = await _productRepository.getProductsByStoreId(event.product.storeId); // atualiza lista
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError('Erro ao editar produto'));
    }
  }
}
