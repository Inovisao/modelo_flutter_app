import 'package:app_skeleton/models/image.dart';
import 'package:app_skeleton/screens/choose_image.dart';
import 'package:flutter/material.dart';

class UploadsScreen extends StatefulWidget {
  const UploadsScreen({super.key});

  @override
  State<UploadsScreen> createState() {
    return _UploadsScreenState();
  }
}

class _UploadsScreenState extends State<UploadsScreen> {
  //final _items = List<String>.generate(10, (index) => 'Item ${index + 1}');
  final _items = List<String>.generate(
    10,
    (index) => UniqueKey().toString(),
  );

  @override
  Widget build(BuildContext context) {
    void _removePhotos(String item) {
      final index = _items.indexOf(item);

      setState(() {
        _items.remove(item);
      });
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          Text('${_items.length} items in queue'),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const ImagePickerScreen(),
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.upload),
          ),
        ], //TODO: force upload
      ),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          return Dismissible(
            onDismissed: (direction) {
              _removePhotos(_items[index]);
              print(_items);
            },
            key: Key(
              _items[index],
            ),
            child: ListTile(
              leading: const CircleAvatar(
                radius: 26,
                child: Icon(Icons.photo),
              ),
              title: Text(_items[index]),
              subtitle: const Text('Photo creation date'),
              trailing: const Icon(Icons.file_upload_off),
            ),
          );
        },
      ),
    );
  }
}
