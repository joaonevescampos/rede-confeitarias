import 'package:equatable/equatable.dart';
import 'package:rede_confeitarias/models/store_model.dart';

abstract class StoreState extends Equatable {
  const StoreState();

  @override
  List<Object?> get props => [];
}

class StoreInitial extends StoreState {}

class StoreLoading extends StoreState {}

class StoreLoaded extends StoreState {
  final List<Store> stores;
  final Store? store; // Também pode ser uma loja específica carregada

  const StoreLoaded({this.stores = const [], this.store});

  @override
  List<Object?> get props => [stores, store];
}

class StoreError extends StoreState {
  final String message;

  const StoreError(this.message);

  @override
  List<Object?> get props => [message];
}
