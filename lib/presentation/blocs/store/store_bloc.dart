import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rede_confeitarias/presentation/blocs/store/store_event.dart';
import 'package:rede_confeitarias/presentation/blocs/store/store_state.dart';
import 'package:rede_confeitarias/repositories/store_repository.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  final StoreRepository _storeRepository;

  StoreBloc(this._storeRepository) : super(StoreInitial()) {
    on<GetAllStoresEvent>(_onGetAllStores);
    on<CreateStoreEvent>(_onCreateStore);
    on<UpdateStoreEvent>(_onUpdateStore);
    on<DeleteStoreEvent>(_onDeleteStore);
  }

  // Carregar todas as lojas
  Future<void> _onGetAllStores(
    GetAllStoresEvent event,
    Emitter<StoreState> emit,
  ) async {
    emit(StoreLoading());
    try {
      final stores = await _storeRepository.getAllStores();
      emit(StoreLoaded(stores: stores)); // Apenas emite StoreLoaded com a lista
    } catch (e) {
      emit(StoreError('Erro ao carregar lojas'));
    }
  }

  // Criar uma loja
  Future<void> _onCreateStore(
    CreateStoreEvent event,
    Emitter<StoreState> emit,
  ) async {
    emit(StoreLoading());
    try {
      await _storeRepository.createStore(event.store);
      final stores = await _storeRepository.getAllStores(); // Atualiza lista
      emit(StoreLoaded(stores: stores)); // Emite lista atualizada
    } catch (e) {
      emit(StoreError('Erro ao criar loja'));
    }
  }

  // Atualizar uma loja
  Future<void> _onUpdateStore(
    UpdateStoreEvent event,
    Emitter<StoreState> emit,
  ) async {
    emit(StoreLoading());
    try {
      await _storeRepository.updateStore(event.store);
      final stores = await _storeRepository.getAllStores(); // Atualiza lista
      emit(StoreLoaded(stores: stores)); // Emite lista atualizada
    } catch (e) {
      emit(StoreError('Erro ao atualizar loja'));
    }
  }

  // Excluir uma loja
  Future<void> _onDeleteStore(
    DeleteStoreEvent event,
    Emitter<StoreState> emit,
  ) async {
    emit(StoreLoading());
    try {
      await _storeRepository.deleteStore(event.id);
      final stores = await _storeRepository.getAllStores(); // Atualiza lista
      emit(StoreLoaded(stores: stores)); // Emite lista atualizada
    } catch (e) {
      emit(StoreError('Erro ao excluir loja'));
    }
  }
}
