import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rede_confeitarias/core/theme/constants/app_colors.dart';

class MultiImagePickerWidget extends StatefulWidget {
  final void Function(List<File>) onImagesSelected;

  const MultiImagePickerWidget({super.key, required this.onImagesSelected});

  @override
  State<MultiImagePickerWidget> createState() => _MultiImagePickerWidgetState();
}

class _MultiImagePickerWidgetState extends State<MultiImagePickerWidget> {
  final List<File> _images = [];
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImages() async {
    final pickedFiles = await _picker.pickMultiImage();

    if (pickedFiles.isNotEmpty) {
      final limitedFiles = pickedFiles.take(5).map((e) => File(e.path)).toList();
      setState(() {
        _images.clear();
        _images.addAll(limitedFiles);
      });
      widget.onImagesSelected(_images);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _images
              .map((image) => Image.file(image, height: 100, width: 100, fit: BoxFit.cover))
              .toList(),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _pickImages,
          child: const Text('Selecionar imagens'),
        ),
        const SizedBox(height: 10),
        Center(child: Text('Você pode selecionar até 5 imagens. A primeira imagem selecionada será usada como a principal.', textAlign: TextAlign.center, style: TextStyle(color: AppColors.secondary, fontSize: 12,)))
      ],
    );
  }
}
