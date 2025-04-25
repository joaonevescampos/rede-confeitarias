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
        color: Colors.white, 
        border: Border.all(
          color: AppColors.terciary, 
          width: 1,          
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(
                  '$imageUrl',
                  width: 100, // largura
                  height: 100, // altura
                  fit: BoxFit.cover, // equivalente ao object-fit: cover
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 150,
                    child: Text('$productName',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Text('R\$ $price', 
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.secondary,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: AppColors.terciary, size: 20, ),
                    onPressed: () {
                      // ação de editar
                      Navigator.pushNamed(context, 'update-product');
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: AppColors.terciary, size: 20,),
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
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
          )
        ],
      ),
    );
  }
}