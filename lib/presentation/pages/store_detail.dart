import 'package:flutter/material.dart';
import 'package:rede_confeitarias/core/theme/constants/app_colors.dart';
import 'package:rede_confeitarias/models/product_model.dart';
import 'package:rede_confeitarias/models/store_model.dart';
import 'package:rede_confeitarias/presentation/components/add_button.dart';
import 'package:rede_confeitarias/presentation/components/custom_drawer.dart';
import 'package:rede_confeitarias/presentation/components/product_widget.dart';
import 'package:rede_confeitarias/presentation/pages/product_register.dart';
import 'package:rede_confeitarias/repositories/store_repository.dart';
import 'package:rede_confeitarias/repositories/product_repository.dart';

class StoreDetail extends StatefulWidget {
  final int? idStore;

  const StoreDetail({Key? key, required this.idStore}) : super(key: key);
  @override
  State<StoreDetail> createState() => _StoreDetailState();
}

class _StoreDetailState extends State<StoreDetail> {
   Store? storeData;
   final ProductRepository _storeRepository = ProductRepository();
  String responseMessage = '';
  List<Product> productsData = [];

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
    final products = await _storeRepository.getProductsByStoreId(widget.idStore!);
    
    setState(() {
      productsData = products;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  child: Text('Nome da loja', 
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
                  ProductInfo(
                    productName: product.productName,
                    price: product.price,
                    description: product.description,
                    imageUrl: product.imageUrl,
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
                MaterialPageRoute(builder: (_) => ProductRegister(idStore: widget.idStore)),
              );
            },
          ),
    );
  }
}