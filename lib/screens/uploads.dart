import 'package:flutter/material.dart';

class UploadsScreen extends StatefulWidget {
  const UploadsScreen({super.key});

  @override
  State<UploadsScreen> createState() {
    return _UploadsScreenState();
  }
}

class _UploadsScreenState extends State<UploadsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.upload)),
        ], //TODO: force upload
      ),
      body: const ListTile(
        //TODO: create ListTile.builder for images in queue
        leading: CircleAvatar(
          radius: 26,
          child: Icon(Icons.photo),
        ),
        title: Text('Image name'),
        subtitle: Text('Image creation date'),
        trailing: Icon(Icons.file_upload_off),
      ),
    );
  }
}
