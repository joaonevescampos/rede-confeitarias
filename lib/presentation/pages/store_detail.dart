import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:rede_confeitarias/core/theme/constants/app_colors.dart';
import 'package:rede_confeitarias/presentation/components/add_button.dart';
import 'package:rede_confeitarias/presentation/components/custom_drawer.dart';
import 'package:rede_confeitarias/presentation/components/product_widget.dart';
import 'package:rede_confeitarias/presentation/pages/product_register.dart';

class StoreDetail extends StatefulWidget {
  const StoreDetail({super.key});
  @override
  State<StoreDetail> createState() => _StoreDetailState();
}

class _StoreDetailState extends State<StoreDetail> {
  //este dado tem que vir do backend (por meio do id, pego as coordenadas de cada loja)
  final coordenates = [LatLng(-7.04105, -34.841602)];
  String storeName = 'Confeitaria do João';
  final products = [
  {
    'id': '1',
    'productName': 'Produto 1 kkd idkj dcfkjdck dckdjckdc',
    'price': 12.90,
    'description': 'Descrição bla bla bla bla bla blabla bla blabla bla blabla bla bla',
    'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQNulBAmbFLYlWLOcQ9d32jzj2XLyMgOkmPeg&s', // exemplo de URL de imagem
  },
  {
    'id': '2',
    'productName': 'Produto 2',
    'price': 12.90,
    'description': 'Descrição bla bla bla bla bla blabla bla blabla bla blabla bla bla',
    'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQNulBAmbFLYlWLOcQ9d32jzj2XLyMgOkmPeg&s', // exemplo de URL de imagem
  },
  {
    'id': '3',
    'productName': 'Produto 3',
    'price': 12.90,
    'description': 'Descrição bla bla bla bla bla blabla bla blabla bla blabla bla bla',
    'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQNulBAmbFLYlWLOcQ9d32jzj2XLyMgOkmPeg&s', // exemplo de URL de imagem
  }
];

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
          Container(
            child: Center(
              child: Text('$storeName', 
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.secondary, 
                  fontSize: 28, 
                  fontWeight: FontWeight.bold,
                ),
              )
            )
          ),
          SizedBox(height: 20,),
          if(products.isEmpty)
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
          if(products.isNotEmpty)
            ...products.map((product) {
              return Column(
                children: [
                  ProductInfo(
                    productName: product['productName'] as String,
                    price: product['price'] as double,
                    description: product['description'] as String,
                    imageUrl: product['imageUrl'] as String,
                  ),
                  const SizedBox(height: 10,)
                ],
              );
            }).toList(),
        ],
      ),
      floatingActionButton: AddButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProductRegister()),
              );
            },
          ),
    );
  }
}