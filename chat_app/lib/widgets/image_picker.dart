import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({super.key, required this.onPickImage});

  final void Function(File pickedImage) onPickImage;

  @override
  State<ImagePickerWidget> createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePickerWidget> {
  File? _imageFile;

  void _pickImage() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );

    if (image == null) {
      return;
    }

    setState(() {
      _imageFile = File(image.path);
    });

    widget.onPickImage(_imageFile!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          foregroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
        ),
        TextButton.icon(
          onPressed: _pickImage,
          icon: const Icon(Icons.image),
          label: Text('Add Image'),
        ),
      ],
    );
  }
}
