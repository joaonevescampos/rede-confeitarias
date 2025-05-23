import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rede_confeitarias/core/theme/constants/app_colors.dart';
import 'package:rede_confeitarias/models/product_model.dart';
import 'package:rede_confeitarias/presentation/components/add_image.dart';
import 'package:rede_confeitarias/presentation/components/custom_drawer.dart';
import 'package:rede_confeitarias/presentation/components/custom_input.dart';
import 'package:rede_confeitarias/presentation/pages/store_detail.dart';
import 'package:rede_confeitarias/repositories/product_repository.dart';
class ProductRegister extends StatefulWidget {
  final int? idStore;

  const ProductRegister({Key? key, required this.idStore}) : super(key: key);

  @override
  State<ProductRegister> createState() => _ProductRegisterState();
}

class _ProductRegisterState extends State<ProductRegister> {
  final _formKey = GlobalKey<FormState>();
  final productNameController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  final ProductRepository _storeRepository = ProductRepository();
  final alternativeImage = 'https://media.istockphoto.com/id/1394758946/pt/vetorial/no-image-raster-symbol-missing-available-icon-no-gallery-for-this-moment-placeholder.jpg?s=612x612&w=0&k=20&c=7ay7BmjmllrzxhLs8iGE9CbhNtxaGXiIvyV6nShL9Zg=';
  String responseMessage = '';
  List<Product> productsData = [];
  List<File> selectedImages = [];
  
  void _handleImagesSelected(List<File> images) {
    setState(() {
      selectedImages = images;
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
          Container(
            child: Center(
              child: Text('Cadastrar Produto', 
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
              child: Text('Preencha o formulário para cadastrar um produto.', 
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
                  Text('Total: ${selectedImages.length} imagem(ns) selecionada(s)'),
              ],
            )
          ),
          const SizedBox(height: 20,),
           ElevatedButton(
            onPressed: () async {
              // Verifica se o formulário é válido (todos os campos obrigatórios preenchidos)
              if (_formKey.currentState!.validate()) {
                final productName = productNameController.text;
                final price = double.parse(priceController.text);
                final description = descriptionController.text;
                final images = alternativeImage;

                   if (widget.idStore == null) {
                    setState(() {
                      productsData = [];
                      responseMessage = 'Loja não encontrada.';
                    });
                    return;
                  }

                 final Product productData = Product(
                        storeId: widget.idStore!,
                        productName: productName,
                        price: price,
                        description: description,
                        imageUrl: images,
                      );

                 //Função para criar produto
                      try {
                        final productId = await _storeRepository.createProduct(productData);
                        setState(() {
                          responseMessage = 'Produto criado com sucesso! ID: $productId e a loja tem id: ${widget.idStore}';
                        });
                        print(responseMessage);
                      } catch (error) {
                        setState(() {
                          responseMessage = 'AQUI - Erro ao criar produto. $error';
                        });
                        print(responseMessage);
                      }

                // Exemplo de feedback visual
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Cadastro realizado com sucesso!', 
                  style: TextStyle(color: Colors.white),), backgroundColor: Colors.green),
                );

                Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StoreDetail(idStore: widget.idStore),
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
            child: const Text('Cadastrar'),
          ),
        ],
      ),
    );
  }
}