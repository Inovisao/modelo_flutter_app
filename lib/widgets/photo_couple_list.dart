import 'dart:io';

import 'package:app_skeleton/models/image.dart';
import 'package:app_skeleton/providers/user_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhotoCoupleList extends ConsumerStatefulWidget {
  const PhotoCoupleList({super.key, required this.photoCouples});

  final List<PhotoCouple> photoCouples;

  @override
  ConsumerState<PhotoCoupleList> createState() => _PhotoCoupleListState();
}

class _PhotoCoupleListState extends ConsumerState<PhotoCoupleList> {
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

    void _removePhotos(String id, File imageForm, File imagePano) {
      ref
          .read(userImagesProvider.notifier)
          .removePhotos(id, imageForm, imagePano);
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
                _removePhotos(
                    widget.photoCouples[index].id,
                    widget.photoCouples[index].imageForm,
                    widget.photoCouples[index].imagePano);
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
              backgroundImage: FileImage(widget.photoCouples[index].imagePano),
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
