import 'package:app_skeleton/models/image.dart';
import 'package:app_skeleton/screens/choose_image.dart';
import 'package:app_skeleton/widgets/photo_couple_list.dart';
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
  final List<PhotoCouple> _allCouples = [];

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
      body: PhotoCoupleList(photoCouples: _allCouples),
    );
  }
}
