import 'package:app_skeleton/models/image.dart';
import 'package:flutter/material.dart';

class PhotoCoupleList extends StatelessWidget{
  const PhotoCoupleList({super.key, required this.photoCouples});

  final List<PhotoCouple> photoCouples;

  @override
  Widget build(BuildContext context) {
    if (photoCouples.isEmpty) {
      return Center(
        child: Text(
          'No photos added yet',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      );
    }

    return  ListView.builder(
          itemCount: photoCouples.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                radius: 26,
                backgroundImage: FileImage(photoCouples[index].imagePano),
              ),
              title: Text(photoCouples[index].id),
              subtitle: Text('Sent at ${photoCouples[index].creationDate}'),
              trailing: photoCouples[index].isUploaded==0 ? const Icon(Icons.file_upload_off) : const Icon(Icons.file_upload),
            );
          },
        );
  }
}