import 'package:flutter/material.dart';
import 'package:rede_confeitarias/core/theme/constants/app_colors.dart';
import 'package:rede_confeitarias/presentation/pages/update_product.dart';
import 'package:rede_confeitarias/repositories/product_repository.dart';

class ProductWidget extends StatefulWidget {
  final int id;
  final String productName;
  final double price;
  final String description;
  final String imageUrl;
  final VoidCallback onDeleted;

  const ProductWidget({
    super.key,
    required this.id,
    required this.productName,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.onDeleted,
  });

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  final ProductRepository _productRepository = ProductRepository();
  String message = '';
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
                  widget.imageUrl,
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
                    child: Text('${widget.productName}',
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
                  Text('R\$ ${widget.price}', 
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
                      // Navigator.pushNamed(context, routeName)

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => 
                        UpdateProduct(id: widget.id)
                        ),
                      );
                    },
                  ),
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
                                    await _productRepository.deleteProduct(widget.id);
                                    widget.onDeleted();
                                  } catch (error) {
                                    final messageError = 'Erro ao deletar produto: $error';
                                    setState(() {
                                      message = messageError;
                                    });
                                  }
                                  Navigator.of(context).pop(); // Fecha o popup após confirmar
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
              )
            ],
          ),
          const SizedBox(height: 20,),
          Text(widget.description,
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
