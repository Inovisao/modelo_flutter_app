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
  // TODO: initState to read notifier and loadPhotos() that have not been uploaded yet

  //final _items = List<String>.generate(10, (index) => 'Item ${index + 1}');
  final _allCouples = [];

  void _addPhotos() async {
    final newPhotoCouple = await Navigator.of(context).push<PhotoCouple>(
      MaterialPageRoute(
        builder: (ctx) => const ImagePickerScreen(),
      ),
    );

    if (newPhotoCouple == null) {
      return;
    }

    setState(() {
      _allCouples.add(newPhotoCouple);
    });
  }

  @override
  Widget build(BuildContext context) {
    //TODO: create variable to watch notifier,use it for FutureBuilder
    void _removePhotos(String item) {
      final index = _allCouples.indexOf(item);

      setState(() {
        _allCouples.remove(item);
      });
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          Text('${_allCouples.length} items in queue'),
          IconButton(
            onPressed: _addPhotos,
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.upload),
          ),
        ], //TODO: force upload
      ),
      body: ListView.builder(
        itemCount: _allCouples.length,
        itemBuilder: (context, index) {
          return Dismissible(
            onDismissed: (direction) {
              _removePhotos(_allCouples[index]);
              print(_allCouples);
            },
            key: Key(
              _allCouples[index],
            ),
            child: ListTile(
              leading: const CircleAvatar(
                radius: 26,
                child: Icon(Icons.photo),
              ),
              title: Text(_allCouples[index]),
              subtitle: const Text('Photo creation date'),
              trailing: const Icon(Icons.file_upload_off),
            ),
          );
        },
      ),
    );
  }
}
