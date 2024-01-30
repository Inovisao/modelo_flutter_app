import 'package:app_skeleton/models/image.dart';
import 'package:flutter/material.dart';

class PhotoCoupleList extends StatefulWidget {
  const PhotoCoupleList({super.key, required this.photoCouples});

  final List<PhotoCouple> photoCouples;

  @override
  State<PhotoCoupleList> createState() => _PhotoCoupleListState();
}

class _PhotoCoupleListState extends State<PhotoCoupleList> {
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
          onDismissed: (direction) {},
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
    // return ListView.builder(
    //       itemCount: photoCouples.length,
    //       itemBuilder: (context, index) {
    //         return ListTile(
    //           leading: CircleAvatar(
    //             radius: 26,
    //             backgroundImage: FileImage(photoCouples[index].imagePano),
    //           ),
    //           title: Text(photoCouples[index].id),
    //           subtitle: Text('Sent at ${photoCouples[index].creationDate}'),
    //           trailing: photoCouples[index].isUploaded==0 ? const Icon(Icons.file_upload_off) : const Icon(Icons.file_upload),
    //         );
    //       },
    //     );
  }
}
