import 'dart:io';

import 'package:app_skeleton/widgets/image_input.dart';
import 'package:flutter/material.dart';

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ImagePickerScreenState();
  }
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  File? _selectedImagePano;
  File? _selectedImageForm;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              ImageInput(
                onPickImage: (image) {
                  _selectedImagePano = image;
                },
                photoContainerTitle: 'Take photo pano',
              ),
              const SizedBox(
                height: 10,
              ),
              ImageInput(
                onPickImage: (image) {
                  _selectedImageForm = image;
                },
                photoContainerTitle: 'Take photo Form',
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Upload'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
