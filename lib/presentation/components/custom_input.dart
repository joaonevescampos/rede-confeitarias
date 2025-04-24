import 'package:flutter/material.dart';
import 'package:rede_confeitarias/core/theme/constants/app_colors.dart';

class CustomInput extends StatelessWidget {
  final String label;
  final TextInputType keyboardType;
  final double? width;
  final int? maxLines;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const CustomInput({
    super.key,
    required this.label,
    required this.keyboardType,
    this.width,
    this.maxLines,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity, // ocupa toda a largura se não passar width
       // ocupa toda a largura se não passar width
      child: TextFormField(
        maxLines: maxLines ?? 1,
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: AppColors.secondary),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.terciary),
          ),
        ),
        validator: (value) =>
            value == null || value.isEmpty ? 'Campo obrigatório. Informe: $label' : null,
      ),
    );
  }
}
