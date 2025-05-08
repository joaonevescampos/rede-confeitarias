import 'package:flutter/material.dart';
import 'package:rede_confeitarias/core/theme/constants/app_colors.dart';
import 'package:rede_confeitarias/models/product_model.dart';
import 'package:rede_confeitarias/models/store_model.dart';
import 'package:rede_confeitarias/presentation/components/add_button.dart';
import 'package:rede_confeitarias/presentation/components/custom_drawer.dart';
import 'package:rede_confeitarias/presentation/components/loading_widget.dart';
import 'package:rede_confeitarias/presentation/components/product_widget.dart';
import 'package:rede_confeitarias/presentation/pages/product_register.dart';
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
    final products = await _productRepository.getProductsByStoreId(widget.idStore!);
    
    setState(() {
      productsData = products;
      isLoading = false;
      print('foi feito o fetch!!!!');

    });

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
                width: 280,
                child: Center(
                  child: Text('$nameOfStore', 
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
                Navigator.pushNamed(context, '/update-store');
              }, 
              icon: Icon(Icons.settings, 
              color: AppColors.secondary, 
              size: 20,))
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