import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; // File type

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onSelectedImage});

  final void Function(File image) onSelectedImage;
  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;

  void _takePicture() async {
    final imagePicker = ImagePicker();
    final picFile =
        await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);

    if (picFile == null) {
      return;
    }

    setState(() {
      _selectedImage = File(
          picFile.path); //File(picFile.path) para convertir el xfile a file
    });

    widget.onSelectedImage(_selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget imageContent = TextButton.icon(
      onPressed: _takePicture,
      icon: const Icon(Icons.camera),
      label: const Text('Take Picture'),
    );

    if (_selectedImage != null) {
      imageContent = GestureDetector(
        onTap: _takePicture,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.file(
            _selectedImage!,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      );
    }
    return Container(
        decoration: BoxDecoration(
          border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.7)),
          borderRadius: BorderRadius.circular(20),
        ),
        height: 250,
        width: double.infinity,
        alignment: Alignment.center,
        child: imageContent);
  }
}
