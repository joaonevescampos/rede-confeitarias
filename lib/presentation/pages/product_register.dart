import 'package:flutter/material.dart';
import 'package:rede_confeitarias/core/theme/constants/app_colors.dart';
import 'package:rede_confeitarias/presentation/components/custom_input.dart';

class ProductRegister extends StatefulWidget {
  const ProductRegister({super.key});

  @override
  State<ProductRegister> createState() => _ProductRegisterState();
}

class _ProductRegisterState extends State<ProductRegister> {
   final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  final imageController = TextEditingController();

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
      drawer: Drawer(),
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
                  controller: nameController,
                ),
                const SizedBox(height: 20,),
                CustomInput(
                  label: 'Valor (real)',
                  keyboardType: TextInputType.text,
                  controller: priceController,
                ),
                const SizedBox(height: 20,),
                CustomInput(
                  label: 'Descrição',
                  keyboardType: TextInputType.text,
                  controller: descriptionController,
                ),
                const SizedBox(height: 20,),
              ],
            )
          )
        ],
      ),
    );
  }
}