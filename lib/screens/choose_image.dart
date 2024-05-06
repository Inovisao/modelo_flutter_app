import 'dart:io';

import 'package:app_skeleton/providers/user_images.dart';
import 'package:app_skeleton/widgets/auth_handler.dart';
import 'package:app_skeleton/widgets/date_replacer.dart';
import 'package:app_skeleton/widgets/image_input.dart';
import 'package:app_skeleton/widgets/modal_sheets.dart';
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
  File? _selectedImage;

  void _savePhotos() {
    if (_selectedImage == null) {
      warningModalBottomSheet(
          context, 'No image selected. Please choose an image');
      return;
    }

    final creationDate = dateReplaceAll(DateTime.now().toString());

    final userInfo = getMapUserInfo();

    ref.read(userImagesProvider.notifier).addPhoto(
          creationDate,
          _selectedImage!,
          userInfo['uid']!,
          userInfo['email']!,
        );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new photo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
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
                    _selectedImage = image;
                  },
                  photoContainerTitle: 'photo',
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: _savePhotos,
                  child: const Text('Upload'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
