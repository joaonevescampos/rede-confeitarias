import 'package:flutter/material.dart';
import 'package:rede_confeitarias/models/store_model.dart';
import 'package:rede_confeitarias/repositories/store_repository.dart';

class CreateStorePage extends StatefulWidget {
  const CreateStorePage({super.key});

  @override
  _CreateStorePageState createState() => _CreateStorePageState();
}

class _CreateStorePageState extends State<CreateStorePage> {
  final StoreRepository _storeRepository = StoreRepository();
  String _responseMessage = '';
  List<Store> _stores = [];
  
  // Objeto fictício de loja para teste
  final Store _store = Store(
    storeName: 'Bolo da Vovó',
    phone: '1234567890',
    longitude: 40.748817,
    latitude: -73.985428,
    address: 'Rua das Flores, 123',
    city: 'Cidade Exemplo',
    neighborhood: 'teste',
    uf: 'SP',
    cep: '12345000',
  );

  // Função para criar a loja
  void _createStore() async {
    try {
      final storeId = await _storeRepository.createStore(_store);
      setState(() {
        _responseMessage = 'Loja criada com sucesso! ID: $storeId';
      });
    } catch (error) {
      setState(() {
        _responseMessage = 'Erro ao criar loja: $error';
      });
    }
  }

  // Função para listar todas as lojas
  void _listStores() async {
    try {
      final stores = await _storeRepository.getAllStores();
      setState(() {
        _stores = stores;
        _responseMessage = 'Lojas listadas com sucesso!';
      });
    } catch (error) {
      setState(() {
        _responseMessage = 'Erro ao listar lojas: $error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar Loja'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Cadastro de Loja',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _createStore,
              child: Text('Criar Loja'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _listStores,
              child: Text('Listar Todas as Lojas'),
            ),
            Text(
              _responseMessage,
              style: TextStyle(
                fontSize: 16,
                color: _responseMessage.startsWith('Erro') ? Colors.red : Colors.green,
              ),
            ),
            SizedBox(height: 20),
            _stores.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: _stores.length,
                      itemBuilder: (context, index) {
                        final store = _stores[index];
                        return ListTile(
                          title: Text(store.storeName),
                          subtitle: Text('${store.address}, ${store.city}'),
                          trailing: Text('ID: ${store.id}'),
                        );
                      },
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
