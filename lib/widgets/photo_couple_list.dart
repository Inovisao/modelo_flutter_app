import 'dart:io';

import 'package:app_skeleton/models/image.dart';
import 'package:app_skeleton/providers/user_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhotoList extends ConsumerStatefulWidget {
  const PhotoList({super.key, required this.photo});

  final List<Photo> photo;

  @override
  ConsumerState<PhotoList> createState() => _PhotoListState();
}

class _PhotoListState extends ConsumerState<PhotoList> {
  void _removePhoto(String id, File image) {
    ref.read(userImagesProvider.notifier).removePhotos(id, image);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.photo.isEmpty) {
      return Center(
        child: Text(
          'No photo added yet',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      );
    }

    // Creates list of images using the image provider
    return ListView.builder(
      itemCount: widget.photo.length,
      itemBuilder: (context, index) {
        // Makes image items dismissable with a swipe
        return Dismissible(
          key: Key(widget.photo[index].id),
          background: Container(color: Colors.red),
          onDismissed: (direction) {
            setState(
              () {
                _removePhoto(widget.photo[index].id,
                    widget.photo[index].image);
                widget.photo.removeAt(index);
              },
            );
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Item dismissed'),
              ),
            );
          },

          // Creates image item
          child: ListTile(
            // Leading preview image
            leading: CircleAvatar(
              radius: 26,
              backgroundImage: FileImage(widget.photo[index].image),
            ),
            // Name of image
            title: Text(widget.photo[index].id),
            // When was the photo taken
            subtitle:
                Text('Sent at ${widget.photo[index].creationDate}'),
            // If the image was uploaded yet, pending
            // TODO: check what to put here, upload status or other info
            trailing: 0 == 0
                ? const Icon(Icons.file_upload_off)
                : const Icon(Icons.file_upload),
            // trailing: widget.photo[index].email == 0
            //     ? const Icon(Icons.file_upload_off)
            //     : const Icon(Icons.file_upload),
          ),
        );
      },
    );
  }
}
