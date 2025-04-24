import 'package:flutter/material.dart';
import 'package:rede_confeitarias/core/theme/constants/app_colors.dart';

class ProductInfo extends StatelessWidget {
  final String productName;
  final double price;
  final String description;
  final String imageUrl;


  const ProductInfo({
    super.key,
    required this.productName,
    required this.price,
    required this.description,
    required this.imageUrl,

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white, // cor de fundo
        border: Border.all(
          color: AppColors.terciary, // cor da borda
          width: 1,           // espessura da borda
        ),
        borderRadius: BorderRadius.circular(12), // bordas arredondadas
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6), // border radius
                child: Image.network(
                  '$imageUrl',
                  width: 100, // largura
                  height: 100, // altura
                  fit: BoxFit.cover, // equivalente ao object-fit: cover
                ),
              ),
              Column(
                children: [
                  Container(
                    // width: double.infinity,
                    child: Text('$productName',
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                      // softWrap: true,
                      // overflow: TextOverflow.visible,
                      ),
                  ),
                  const SizedBox(height: 10,),
                  Text('$price', 
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.secondary,
                    ),
                    // softWrap: true,
                    // overflow: TextOverflow.visible,
                  ),
                ],
              ),
              Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: AppColors.terciary),
                    onPressed: () {
                      // ação de editar
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: AppColors.terciary),
                    onPressed: () {
                      // ação de deletar
                    },
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 20,),
          Text('$description',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.secondary,
            ),
            // maxLines: 4,
            // overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}