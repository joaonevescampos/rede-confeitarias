import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rede_confeitarias/presentation/blocs/store/store_event.dart';
import 'package:rede_confeitarias/presentation/blocs/store/store_state.dart';
import 'package:rede_confeitarias/repositories/store_repository.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  final StoreRepository storeRepository;

  StoreBloc(this.storeRepository) : super(StoreInitial()) {
    on<GetAllStoresEvent>(_onGetAllStores);
    on<CreateStoreEvent>(_onCreateStore);
    on<UpdateStoreEvent>(_onUpdateStore);
    on<GetStoreByIdEvent>(_onGetStoreById);
    on<DeleteStoreEvent>(_onDeleteStore);
  }

  Future<void> _onGetAllStores(
    GetAllStoresEvent event,
    Emitter<StoreState> emit,
  ) async {
    emit(StoreLoading());
    try {
      final stores = await storeRepository.getAllStores();
      emit(StoreLoaded(stores));
    } catch (e) {
      emit(StoreError('Erro ao carregar lojas'));
    }
  }

  Future<void> _onCreateStore(
    CreateStoreEvent event,
    Emitter<StoreState> emit,
  ) async {
    emit(StoreLoading());
    try {
      await storeRepository.createStore(event.store);
      final stores = await storeRepository.getAllStores();
      emit(StoreLoaded(stores));
    } catch (e) {
      emit(StoreError('Erro ao criar loja'));
    }
  }

  Future<void> _onUpdateStore(
    UpdateStoreEvent event,
    Emitter<StoreState> emit,
  ) async {
    emit(StoreLoading());
    try {
      await storeRepository.updateStore(event.store);
      final stores = await storeRepository.getAllStores();
      emit(StoreLoaded(stores));
    } catch (e) {
      emit(StoreError('Erro ao atualizar loja'));
    }
  }

  Future<void> _onGetStoreById(
    GetStoreByIdEvent event,
    Emitter<StoreState> emit,
  ) async {
    emit(StoreLoading());
    try {
      final store = await storeRepository.getStoreById(event.id);
      if (store != null) {
      emit(StoreSingleLoaded(store));
      } else {
        emit(StoreError('Loja não encontrada'));
      }
    } catch (e) {
      emit(StoreError('Erro ao buscar loja'));
    }
  }

  Future<void> _onDeleteStore(
    DeleteStoreEvent event,
    Emitter<StoreState> emit,
  ) async {
    emit(StoreLoading());
    try {
      await storeRepository.deleteStore(event.id);
      final stores = await storeRepository.getAllStores();
      emit(StoreLoaded(stores));
    } catch (e) {
      emit(StoreError('Erro ao deletar loja'));
    }
  }
}
