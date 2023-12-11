import 'package:flutter/material.dart';

class UploadsScreen extends StatefulWidget {
  const UploadsScreen({super.key});

  @override
  State<UploadsScreen> createState() {
    return _UploadsScreenState();
  }
}

class _UploadsScreenState extends State<UploadsScreen> {
  final items = List<String>.generate(10, (index) => 'Item ${index + 1}');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.upload)),
        ], //TODO: force upload
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const CircleAvatar(
              radius: 26,
              child: Icon(Icons.photo),
            ),
            title: Text(items[index]),
            subtitle: const Text('Image creation date'),
            trailing: const Icon(Icons.file_upload_off),
          );
        },
      ),
    );
  }
}
