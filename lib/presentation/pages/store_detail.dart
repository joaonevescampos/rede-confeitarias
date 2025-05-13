import 'package:flutter/material.dart';
import 'package:rede_confeitarias/core/theme/constants/app_colors.dart';
import 'package:rede_confeitarias/models/product_model.dart';
import 'package:rede_confeitarias/models/store_model.dart';
import 'package:rede_confeitarias/presentation/components/add_button.dart';
import 'package:rede_confeitarias/presentation/components/custom_drawer.dart';
import 'package:rede_confeitarias/presentation/components/loading_widget.dart';
import 'package:rede_confeitarias/presentation/components/product_widget.dart';
import 'package:rede_confeitarias/presentation/pages/product_register.dart';
import 'package:rede_confeitarias/presentation/pages/update_store.dart';
import 'package:rede_confeitarias/repositories/product_repository.dart';
import 'package:rede_confeitarias/repositories/store_repository.dart';

class StoreDetail extends StatefulWidget {
  final int? idStore;

  const StoreDetail({Key? key, required this.idStore}) : super(key: key);
  @override
  State<StoreDetail> createState() => _StoreDetailState();
}

class _StoreDetailState extends State<StoreDetail> {
  bool isLoading = true;
  String? nameOfStore;
  String message = '';

   final ProductRepository _productRepository = ProductRepository();
  String responseMessage = '';
  List<Product> productsData = [];

  final StoreRepository _storeRepository = StoreRepository();
   String responseMessageStore = '';
  Store? storeData;

  @override
  void initState() {
    super.initState();
    fetchStore();
  }

  Future<void> fetchStore() async {
    if (widget.idStore == null) {
      setState(() {
        productsData = [];
        responseMessage = 'Loja não encontrada.';
      });
      return;
    }
    // Exemplo: usando seu StoreRepository para pegar a loja
    try {
      final products = await _productRepository.getProductsByStoreId(widget.idStore!);
    
      setState(() {
        productsData = products;
        isLoading = false;
        print('foi feito o fetch!!!!');
      });

    } catch (error) {
       setState(() {
        productsData = [];
        isLoading = false;
        print('falha no fetch!!! $error');
      });
    }
    
    final id = widget.idStore;
    final storeDetail = await _storeRepository.getStoreById(id!);

    setState(() {
      storeData = storeDetail;
      nameOfStore = storeDetail?.storeName;
    });

    // print('storeId: $id');
    // print(storeData?.storeName);
    // print(storeData?.phone);
    // print(storeData?.id);
    // print(storeData?.city);
    // print(storeData?.latitude);
    // print(storeData?.longitude);
    // print(storeData?.cep);
    // print(storeData?.uf);
  }

  @override
  Widget build(BuildContext context) {
    if(isLoading) {
      return LoadingWidget();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Redes de confeitarias', 
          style: TextStyle(
            fontSize: 14, 
            fontWeight: FontWeight.bold,
          ),
          ),
      ),
      drawer: CustomDrawer(),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 240,
                child: Center(
                  child: Text('${storeData?.storeName}', 
                    style: TextStyle(
                      color: AppColors.secondary, 
                      fontSize: 20, 
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  )
                )
              ),
              IconButton(onPressed: (){
                Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => 
                UpdateStore(idStore: widget.idStore)
                ),
              ).then((_) => fetchStore());
              }, 
              icon: Icon(Icons.edit, 
              color: AppColors.secondary, 
              size: 20,)),
              IconButton(
                icon: Icon(Icons.delete, color: AppColors.terciary, size: 20),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        titlePadding: EdgeInsets.only(top: 16, left: 16, right: 8),
                        contentPadding: EdgeInsets.all(16),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Confirmação'),
                            IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () => Navigator.of(context).pop(), // fecha o popup
                            )
                          ],
                        ),
                        content: Text('Você tem certeza que deseja excluir este item?'),
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            onPressed: () async {
                              try {
                                fetchStore();
                                await _storeRepository.deleteStore(widget.idStore!);
                              } catch (error) {
                                final messageError = 'Erro ao deletar loja: $error';
                                setState(() {
                                  message = messageError;
                                });
                              }
                              Navigator.of(context).pop();
                              // Navigator.pushNamed(context, '/store-details');
                            },
                            child: Text('Excluir'),
                          ),
                          
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Fecha o popup
                            },
                            child: Text('Cancelar'),
                          ),
                            ],
                          )
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 20,),
          if(productsData.isEmpty)
            Container(
              child: Center(
                child: Text('Tenta acesso a todos produtos cadastrados desta loja. Aperte no botão + para criar novo produto.', 
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.secondary, 
                    fontSize: 16, 
                  ),
                )
              )
            ), 
          if(productsData.isNotEmpty)
            ...productsData.map((product) {
              return Column(
                children: [
                  ProductWidget(
                    id: product.id!,
                    productName: product.productName,
                    price: product.price,
                    description: product.description,
                    imageUrl: product.imageUrl,
                    onDeleted: fetchStore,
                  ),
                  const SizedBox(height: 10,)
                ],
              );
            }).toList(),
          const SizedBox(height: 60,),

        ],
      ),
      floatingActionButton: AddButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => 
                ProductRegister(idStore: widget.idStore)
                ),
              ).then((_) => fetchStore());
            },
          ),
    );
  }
}