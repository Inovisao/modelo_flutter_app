import 'dart:io';

import 'package:app_skeleton/providers/user_images.dart';
import 'package:app_skeleton/widgets/date_replacer.dart';
import 'package:app_skeleton/widgets/image_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImagePickerScreen extends ConsumerStatefulWidget {
  const ImagePickerScreen({super.key});

  @override
  ConsumerState<ImagePickerScreen> createState() {
    return _ImagePickerScreenState();
  }
}

class _ImagePickerScreenState extends ConsumerState<ImagePickerScreen> {
  final baseNameFromDate = dateReplaceAll(DateTime.now().toString());

  File? _selectedImagePano;
  File? _selectedImageForm;

  void _saveImages() {
    if (_selectedImageForm == null || _selectedImagePano == null) {
      return;
    }

    ref.read(userImagesProvider.notifier).addImages(
          baseNameFromDate,
          _selectedImageForm!,
          _selectedImagePano!,
        );
  }

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
                onPressed: () {
                  print(baseNameFromDate);
                },
                child: const Text('Upload'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
