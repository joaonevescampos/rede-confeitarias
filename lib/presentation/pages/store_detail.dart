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
  String storeName = 'Confeitaria do João em Inter - Cabedelo';
  final products = [
  {
    'id': '1',
    'productName': 'Produto com um nome muito longo para minha loja',
    'price': 12.90,
    'description': 'Descrição bla bla bla bla bla blabla bla blabla bla blabla bla bla Descrição bla bla bla bla bla blabla bla blabla bla blabla bla bla Descrição bla bla bla bla bla blabla bla blabla bla blabla bla bla Descrição bla bla bla bla bla blabla bla blabla bla blabla bla bla',
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
          Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 280,
                child: Center(
                  child: Text('$storeName', 
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
          const SizedBox(height: 60,),

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