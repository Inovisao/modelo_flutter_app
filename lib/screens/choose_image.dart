import 'dart:io';

import 'package:app_skeleton/providers/user_images.dart';
import 'package:app_skeleton/widgets/date_replacer.dart';
import 'package:app_skeleton/widgets/image_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:native_exif/native_exif.dart';

class ImagePickerScreen extends ConsumerStatefulWidget {
  const ImagePickerScreen({super.key});

  @override
  ConsumerState<ImagePickerScreen> createState() {
    return _ImagePickerScreenState();
  }
}

class _ImagePickerScreenState extends ConsumerState<ImagePickerScreen> {
  File? _selectedImagePano;
  File? _selectedImageForm;


  void _savePhotos() {
    if (_selectedImageForm == null || _selectedImagePano == null) {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: 130,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text('Please choose two images'),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Close'))
                ],
              ),
            ),
          );
        },
      );
      return;
    }

    final creationDate = dateReplaceAll(DateTime.now().toString());
    
    // TODO: read notifier and run AddPhotos()
    // ref.read(userImagesProvider.notifier).addImages(
    //       creationDate,
    //       _selectedImageForm!,
    //       _selectedImagePano!,
    //     );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new photos'),
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
                    _selectedImagePano = image;
                  },
                  photoContainerTitle: 'photo pano',
                ),
                const SizedBox(
                  height: 10,
                ),
                ImageInput(
                  onPickImage: (image) {
                    _selectedImageForm = image;
                  },
                  photoContainerTitle: 'photo Form',
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
