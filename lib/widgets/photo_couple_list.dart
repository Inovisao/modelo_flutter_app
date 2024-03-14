import 'dart:io';

import 'package:app_skeleton/models/image.dart';
import 'package:app_skeleton/providers/user_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhotoCoupleList extends ConsumerStatefulWidget {
  const PhotoCoupleList({super.key, required this.photoCouples});

  final List<Photo> photoCouples;

  @override
  ConsumerState<PhotoCoupleList> createState() => _PhotoCoupleListState();
}

class _PhotoCoupleListState extends ConsumerState<PhotoCoupleList> {
  void _removePhotos(String id, File image) {
    ref.read(userImagesProvider.notifier).removePhotos(id, image);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.photoCouples.isEmpty) {
      return Center(
        child: Text(
          'No photos added yet',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      );
    }

    return ListView.builder(
      itemCount: widget.photoCouples.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: Key(widget.photoCouples[index].id),
          background: Container(color: Colors.red),
          onDismissed: (direction) {
            setState(
              () {
                _removePhotos(widget.photoCouples[index].id,
                    widget.photoCouples[index].image);
                widget.photoCouples.removeAt(index);
              },
            );
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Item dismissed'),
              ),
            );
          },
          child: ListTile(
            leading: CircleAvatar(
              radius: 26,
              backgroundImage: FileImage(widget.photoCouples[index].image),
            ),
            title: Text(widget.photoCouples[index].id),
            subtitle:
                Text('Sent at ${widget.photoCouples[index].creationDate}'),
            trailing: widget.photoCouples[index].isUploaded == 0
                ? const Icon(Icons.file_upload_off)
                : const Icon(Icons.file_upload),
          ),
        );
      },
    );
  }
}
