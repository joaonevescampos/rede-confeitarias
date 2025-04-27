import 'package:equatable/equatable.dart';
import 'package:rede_confeitarias/models/store_model.dart';

abstract class StoreEvent extends Equatable {
  const StoreEvent();

  @override
  List<Object?> get props => [];
}

class GetAllStoresEvent extends StoreEvent {}

class CreateStoreEvent extends StoreEvent {
  final Store store;

  const CreateStoreEvent({required this.store});

  @override
  List<Object?> get props => [store];
}

class UpdateStoreEvent extends StoreEvent {
  final Store store;

  const UpdateStoreEvent(this.store);

  @override
  List<Object?> get props => [store];
}

class GetStoreByIdEvent extends StoreEvent {
  final int id;

  const GetStoreByIdEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class DeleteStoreEvent extends StoreEvent {
  final int id;

  const DeleteStoreEvent(this.id);

  @override
  List<Object?> get props => [id];
}
