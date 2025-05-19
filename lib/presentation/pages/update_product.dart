import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rede_confeitarias/core/theme/constants/app_colors.dart';
import 'package:rede_confeitarias/models/product_model.dart';
import 'package:rede_confeitarias/presentation/components/add_image.dart';
import 'package:rede_confeitarias/presentation/components/custom_drawer.dart';
import 'package:rede_confeitarias/presentation/components/custom_input.dart';
import 'package:rede_confeitarias/presentation/pages/store_detail.dart';
import 'package:rede_confeitarias/repositories/product_repository.dart';
class UpdateProduct extends StatefulWidget {
  final int id;
  const UpdateProduct({
    required this.id,
    super.key,
    });

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  final ProductRepository _productRepository = ProductRepository();
  String responseMessage = '';
  final alternativeImage = 'https://media.istockphoto.com/id/1394758946/pt/vetorial/no-image-raster-symbol-missing-available-icon-no-gallery-for-this-moment-placeholder.jpg?s=612x612&w=0&k=20&c=7ay7BmjmllrzxhLs8iGE9CbhNtxaGXiIvyV6nShL9Zg=';
  Product? productData;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController priceController = TextEditingController();
  late TextEditingController descriptionController = TextEditingController();
  late TextEditingController productNameController = TextEditingController();

  List<File> selectedImages = [];

  void _handleImagesSelected(List<File> images) {
    setState(() {
      selectedImages = images;
    });
  }
  @override
  void initState() {
    super.initState();
    fetchProduct();
  }

  Future<void> fetchProduct() async {
    final product = await _productRepository.getProductById(widget.id);
    setState(() {
      productData = product;
      productNameController = TextEditingController(text: productData?.productName);
      priceController = TextEditingController(text: '${productData?.price}');
      descriptionController = TextEditingController(text: productData?.description);
    });
  }

  @override
  void dispose() {
    productNameController.dispose();
    super.dispose();
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
          Container(
            child: Center(
              child: Text('Atualizar Produto: ${productData?.productName}', 
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
          Container(
            child: Center(
              child: Text('Edite o formulário para atualizar o produto.', 
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.secondary, 
                  fontSize: 16, 
                ),
              )
            )
          ), 
          const SizedBox(height: 20,),
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomInput(
                  label: 'Nome do produto',
                  keyboardType: TextInputType.text,
                  maxLength: 40,
                  controller: productNameController,
                ),
                const SizedBox(height: 20,),
                CustomInput(
                  label: 'Valor (R\$)',
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  controller: priceController,
                ),
                const SizedBox(height: 20,),
                CustomInput(
                  label: 'Descrição',
                  keyboardType: TextInputType.text,
                  maxLines: 5,
                  maxLength: 180,
                  controller: descriptionController,
                ),
                const SizedBox(height: 20,),
                 MultiImagePickerWidget(onImagesSelected: _handleImagesSelected),
                  // Text('Total: ${selectedImages.length} imagem(ns) selecionada(s)'),
                  // if (selectedImage != null)
                  //   print('Imagem selecionada: ${selectedImage!.path}'),
              ],
            )
          ),
          const SizedBox(height: 20,),
           ElevatedButton(
            onPressed: () async {
              // Verifica se o formulário é válido (todos os campos obrigatórios preenchidos)
              if (_formKey.currentState!.validate()) {
                final productName = productNameController.text;
                final price = priceController.text;
                final description = descriptionController.text;
                final images = alternativeImage;
                

                Product newProduct = Product(
                  id: widget.id,
                  storeId: productData!.storeId,
                  productName: productName,
                  price: double.parse(price),
                  description: description,
                  imageUrl: images
                );

                try {
                  await _productRepository.updateProduct(newProduct);
                 
                  setState(() {
                    responseMessage = 'Produto atualizado com sucesso';
                  });
                  print(responseMessage);
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Atualização feita com sucesso!', 
                    style: TextStyle(color: Colors.white),), backgroundColor: Colors.green),
                  );
                  
                } catch (error) {
                  
                  setState(() {
                    responseMessage = 'Erro ao atualizar produto: $error';
                  });
                  print(responseMessage);
                 
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Houve um erro interno na atualização do produto. Tente mais tarde!', 
                    style: TextStyle(color: Colors.white),), backgroundColor: Colors.red),
                  );
                }

                Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StoreDetail(idStore: productData?.storeId),
                        ),
                      );
                
              } else {
                // Caso algum campo obrigatório esteja vazio
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Por favor, preencha todos os campos obrigatórios.', 
                    style: TextStyle(color: Colors.white),), 
                    backgroundColor: Colors.red),
                );
              }
            },
            child: const Text('Atualizar'),
          ),
        ],
      ),
    );
  }
}